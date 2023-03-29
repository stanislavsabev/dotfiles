#!/usr/bin/env python3
import os
import re
import subprocess
import argparse
import collections
import logging
from typing import Dict


logging.basicConfig(level=logging.DEBUG)

LATEST_MIGRATION = "LATEST_MIGRATION"
_USAGE = "rebase_mig.py [-h] [-d DEST=curr-branch] [-b BASE=master]"

Mig = collections.namedtuple("Mig", "ndx,name")


def cmd(command, cwd=None):
    kwargs = dict(shell=True, cwd=cwd, stdout=subprocess.PIPE)
    res = subprocess.Popen(command, **kwargs)
    out, err = res.communicate()
    if err:
        raise subprocess.SubprocessError(str(err, encoding="utf-8"))
    if out:
        out = str(out, encoding="utf-8").rstrip("\n")
        logging.info("cmd: %s", out)
        return out
    return None


def parse_args():
    p = argparse.ArgumentParser(usage=_USAGE)
    p.add_argument("-d", "--dest", action="store", type=str)
    p.add_argument("-b", "--base", action="store", type=str, default="master")
    args = p.parse_args()
    return args


def main():
    args = parse_args()
    base, dest = args.base, args.dest
    if not dest:
        dest = cmd("git curr-branch", cwd=os.getcwd())
    if not dest:
        msg = "Invalid branch destination name."
        logging.error(msg)
        return msg

    if dest == base:
        msg = f"Invalid branch names, base = dest = '{base}'."
        logging.error(msg)
        return msg

    proj_dir = os.environ["MIGRATIONS_DIR"]

    dest_path = os.path.join(proj_dir, dest)
    base_path = os.path.join(proj_dir, base)

    cmd("git pull", cwd=base_path)

    latest: Dict[str, Mig] = {}
    for branch in [base, dest]:
        with open(
            os.path.join(proj_dir, branch, "migrations", LATEST_MIGRATION),
            mode="r",
            encoding="utf-8",
        ) as fp:
            latest_mig = fp.readline()
            fname = latest_mig.split(".py")[0]
            if not (m := re.match(r"^\d+", fname)):
                raise ValueError(
                    f"Branch {branch}: Invalid value in '{LATEST_MIGRATION}'"
                )
            ndx = int(m.group(0))
            latest[branch] = Mig(ndx=ndx, name=fname)

    if latest[base].ndx < latest[dest].ndx:
        msg = f"Cannot rebase {dest}, " f"{latest[dest].name} > {latest[base].name}"
        logging.info(msg)
        return msg

    # Temporarily change LATEST_MIGRATION to be same as in base
    with open(
        os.path.join(dest_path, "migrations", LATEST_MIGRATION),
        mode="w",
        encoding="utf-8",
    ) as fp:
        fp.write(f"{latest[base].name}.py\n")

    # Rename latest migration file on dest if it has
    # same index as on base
    ndx, name = latest[dest]
    if latest[base].ndx == ndx:
        new_ndx = ndx + 1
        new_name = str.replace(name, str(ndx), str(new_ndx), 1)
        latest[dest] = Mig(new_ndx, new_name)
        cmd(f"mv migrations/{name}.py migrations/{new_name}.py", cwd=dest_path)

    cmd(f"git add --all", cwd=dest_path)
    cmd("git commit --amend --no-edit", cwd=dest_path)
    cmd(f"git rebase {base}", cwd=dest_path)

    # Update LATEST_MIGRATION on dest to correct migration name
    with open(
        os.path.join(dest_path, "migrations", LATEST_MIGRATION),
        mode="w",
        encoding="utf-8",
    ) as fp:
        fp.write(f"{latest[dest].name}.py\n")

    cmd(f"git add --all", cwd=dest_path)
    cmd("git commit --amend --no-edit", cwd=dest_path)


if __name__ == "__main__":
    main()
