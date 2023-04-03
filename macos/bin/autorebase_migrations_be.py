#!/usr/bin/env python3
"""Autorebase ggrc_migrations"""
import os
import sys
import re
import subprocess
import argparse
import logging


logging.basicConfig(level=logging.DEBUG)

script_name = os.path.basename(__file__)
_USAGE = f"{script_name} [-h] [-d DEST=curr-branch] [-b BASE=master]"


class Branch:
    """Branch representation in ggrc_migrations"""

    def __init__(self, branch, proj) -> None:
        self.branch = branch
        self.proj = proj
        self.path = os.path.join(proj, branch)

        self.ndx = -1
        self.ndx_str = ""
        self._name = ""

    @property
    def name(self):
        """Migration file name"""
        return self._name

    def update_migration_prefix(self, ndx):
        """Update the prefix for the latest migration"""
        new_ndx = ndx + 1
        new_ndx_str = self.ndx_str.replace(str(self.ndx), str(new_ndx))
        new_name = new_ndx_str + self._name[len(new_ndx_str) :]

        src = os.path.join(self.path, "migrations", self._name)
        dst = os.path.join(self.path, "migrations", new_name)

        cmd(f"mv {src} {dst}",
            cwd=self.path)

        self.ndx = new_ndx
        self.ndx_str = new_ndx_str
        self._name = new_name

    @property
    def ltm(self):
        """File path for LATEST_MIGRATION file"""
        return os.path.join(self.path, "migrations", "LATEST_MIGRATION")

    def parse_latest_migration(self, pull=False):
        """Parse the value in migrations/LATEST_MIGRATION file"""
        if pull:
            cmd("git pull", cwd=self.path)

        with open(
            self.ltm,
            mode="r",
            encoding="utf-8",
        ) as fp:
            self._name = fp.readline().rstrip('\n')
        m = re.match(r"^\d+", self._name)
        if not m:
            raise ValueError(
                (
                    f"Branch {self.branch}, invalid value in "
                    f"'LATEST_MIGRATION': {self._name}"
                )
            )

        self.ndx = int(m.group(0))
        self.ndx_str = str(m.group(0))

    def update_latest_migration_file(self):
        """Update LATEST_MIGRATION on dest to correct migration name"""
        with open(
            os.path.join(self.path, "migrations", "LATEST_MIGRATION"),
            mode="w",
            encoding="utf-8",
        ) as fp:
            fp.write(f"{self.name}\n")


def cmd(command, cwd=None):
    """Execute command line"""
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
    """Parse arguments for this script"""
    p = argparse.ArgumentParser(usage=_USAGE)
    p.add_argument("-d", "--dest", action="store", type=str)
    p.add_argument("-b", "--base", action="store", type=str, default="master")
    args = p.parse_args()
    return args


def main():
    """Entry point for this script"""
    args = parse_args()
    base_b, dest_b = args.base, args.dest
    proj_dir = os.environ["MIGRATIONS_DIR"]

    if not dest_b:
        dest_b = cmd("git curr-branch", cwd=os.getcwd())
    if not dest_b:
        msg = "Invalid branch destination name."
        logging.error(msg)
        return 1

    if dest_b == base_b:
        msg = f"Invalid branch names, base = dest = '{base_b}'."
        logging.error(msg)
        return 1

    # migs: List[Migration] = []

    base = Branch(base_b, proj_dir)
    dest = Branch(dest_b, proj_dir)
    base.parse_latest_migration(pull=True)
    dest.parse_latest_migration()

    if base.ndx < dest.ndx:
        msg = f"Cannot rebase {dest}, " f"{dest.name} > {base.name}"
        logging.info(msg)

    # Temporarily change LATEST_MIGRATION to be same as in base
    cmd(command=f"cp -f {base.ltm} {dest.ltm}")

    # Rename latest migration file on dest if it has
    # same index as on base
    dest.update_migration_prefix(base.ndx)

    cmd("git add --all", cwd=dest.path)
    cmd("git commit --amend --no-edit", cwd=dest.path)
    cmd(f"git rebase {base.branch}", cwd=dest.path)

    # Update LATEST_MIGRATION on dest to correct migration name
    dest.update_latest_migration_file()

    cmd("git add --all", cwd=dest.path)
    cmd("git commit --amend --no-edit", cwd=dest.path)

    logging.info(
        "Successfully rebased branch `%s` from base `%s`",
        dest.branch,
        base.branch,
    )
    logging.info("Remember to push changes")
    return 0


if __name__ == "__main__":
    sys.exit(main())
