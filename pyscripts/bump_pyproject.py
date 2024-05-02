import sys
from dataclasses import dataclass, field
from pathlib import Path
from typing import Iterable
import re

import tomlkit
from tomlkit.toml_document import TOMLDocument
import traceback


@dataclass
class LibLine:
    lib: str
    split_by: str | None = field(default=None)
    ver: str | None = field(default=None)
    remainder: str = field(default="")


LibLineDict = dict[str, LibLine]


def bad_line(line: str):
    line = line.strip()
    if not line:
        return True
    return line[0] in {"-", "#"}


def choose_split_by(line: str) -> str | None:
    for delim in ["==", ">=", "<=", "<", ">"]:
        if line.find(delim) != -1:
            return delim
    return None


def lib_versions(lines: Iterable[str], split_by: str | None = None) -> LibLineDict:
    data = {}
    for line in lines:
        if bad_line(line):
            continue
        if line_split_by := split_by or choose_split_by(line):
            lib, ver = line.rstrip("\n").split(line_split_by)
            ver = ver.strip()
        else:
            lib, ver = line.rstrip("\n"), None
        lib = lib.strip()
        data[lib] = LibLine(lib=lib, split_by=line_split_by, ver=ver)
    return data


def extract_requirements_in(path: Path) -> dict[str, set[str]]:
    res = {}

    for req_file in path.glob("requirements*.in"):
        key = req_file.with_suffix("").name
        data = set()
        with req_file.open() as fp:
            for line in fp:
                if bad_line(line):
                    continue
                if m := re.match(r"^\s*([a-zA-Z0-9_-]+)", line.rstrip("\n").lower()):
                    data.add(m.group(1))
        res[key] = data
    return res


def extract_requirements_txt(path: Path, req_in) -> dict[str, LibLineDict]:
    res = {}

    for req_file in path.glob("requirements*.txt"):
        key = req_file.with_suffix("").name
        if key not in req_in:
            continue
        with req_file.open() as fp:
            data = lib_versions(lines=fp, split_by="==")
            # Filter only lines that are in requirements*.in
            data = {lib: libline for lib, libline in data.items() if lib in req_in[key]}
        res[key] = data
    return res


def help_msg():
    lines = ["usage: bump-toml-deps [-h] PATH"]
    lines += [
        f"  {line}"
        for line in [
            "Update package versions in pyproject.toml",
            "",
            "PATH      Directory containing pyproject.toml and requirements/",
        ]
    ]
    return "\n".join(lines)


def validate_args(argv: list[str]) -> Path:
    argv = argv[1:]
    if not argv:
        raise ValueError("Missing argument for PATH.")

    arg = sys.argv[1]
    if arg.startswith("-"):
        if arg.lstrip("-") in [h for h in "h/help".split("/")]:
            print(help_msg())
            sys.exit(0)
        else:
            raise ValueError(f"Invalid argument {arg}")

    path = Path(arg)
    if not path.joinpath("pyproject.toml").is_file():
        raise ValueError("Root directory is missing pyproject.toml")
    if not path.joinpath("requirements").is_dir():
        raise ValueError("Root directory is missing requirements/")
    return path


def read_toml(path: Path) -> tuple[TOMLDocument, dict[str, LibLineDict]]:
    deps = {}
    with path.open(mode="r") as fp:
        toml = tomlkit.load(fp)

    if "project" in toml and "dependencies" in toml["project"]:
        data = lib_versions(lines=toml["project"]["dependencies"])
        deps["dependencies"] = data

    if (
        "project" in toml
        and "optional-dependencies" in toml["project"]
        and "dev" in toml["project"]["optional-dependencies"]
    ):
        data = lib_versions(lines=toml["project"]["optional-dependencies"]["dev"])
        deps["optional-dependencies"] = data
    return toml, deps


def compare_reqs(txt: set[str], toml: set[str]) -> tuple[set[str], set[str], set[str]]:
    txt, toml = set(txt), set(toml)
    same = toml.intersection(txt)
    dropped = toml.difference(txt)
    new = txt.difference(toml)
    return same, dropped, new


def update_versions(toml: LibLineDict, txt: LibLineDict) -> set[str]:
    updated: set[str] = set()
    for lib, toml_libline in toml.items():
        txt_libline = txt[lib]
        if toml_libline.ver != txt_libline.ver:
            toml_libline.ver = txt_libline.ver
            toml_libline.split_by = txt_libline.split_by
            updated.add(lib)
    return updated


def update_toml_section(
    req_toml: dict[str, LibLineDict],
    req_txt: dict[str, LibLineDict],
    tkey: str,
    rkey: str,
):
    toml = req_toml.get(tkey)
    txt = req_txt.get(rkey)
    if not all([toml, txt]):
        print(f"Skipping pair {tkey}, {rkey}")
        return
    same, dropped, new = compare_reqs(txt=set(txt), toml=set(toml))
    toml = {lib: val for lib, val in toml.items() if lib in same}
    updated = update_versions(toml=toml, txt=txt)
    toml.update({lib: val for lib, val in txt.items() if lib in new})
    req_toml[tkey] = toml

    report = []
    for category, items in [("dropped", dropped), ("added", new), ("updated", updated)]:
        if items:
            report.append(f"  > {category}:\n\t{items}")
    if report:
        report.insert(0, f"{tkey}:")
        print("\n".join(report))


def update_toml_contents(req_toml: dict[str, LibLineDict], toml_contents: TOMLDocument) -> None:
    for key, subkey in [("dependencies", None), ("optional-dependencies", "dev")]:
        items = tomlkit.array()
        for libline in req_toml[key].values():
            # Update dependencies line
            items.add_line(f"{libline.lib}{libline.split_by}{libline.ver}")
        items.add_line(indent="")
        if subkey:
            toml_contents["project"][key][subkey] = items
        else:
            toml_contents["project"][key] = items


def main():
    path = validate_args(sys.argv)

    req_path = path.joinpath("requirements")
    req_in = extract_requirements_in(req_path)
    req_txt = extract_requirements_txt(req_path, req_in=req_in)
    toml_contents, req_toml = read_toml(path.joinpath("pyproject.toml"))

    for tkey, rkey in [
        ("dependencies", "requirements"),
        ("optional-dependencies", "requirements-dev"),
    ]:
        update_toml_section(req_toml=req_toml, req_txt=req_txt, tkey=tkey, rkey=rkey)
        update_toml_contents(req_toml=req_toml, toml_contents=toml_contents)

    with path.joinpath("pyproject.toml").open("w") as fp:
        tomlkit.dump(toml_contents, fp)


if __name__ == "__main__":
    try:
        main()
    except Exception:
        traceback.print_exc(limit=2)
        print("See -h for help.")
