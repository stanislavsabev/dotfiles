#!/usr/bin/env python3
"""Edit bash history (prototype)"""


def main():
    """Edit bash history (prototype)"""
    seen = set()
    out = []

    with open("bash_history", "r", encoding='utf-8') as fd:
        lines = fd.readlines()

    rm = False
    for line in reversed(lines):
        if line == '\n':
            continue
        if line in seen:
            rm = True
            continue

        if rm and line.startswith("#"):
            rm = False
            continue
        rm = False
        seen.add(line)
        out.append(line)

    with open("bash_history", "w", encoding='utf-8') as fd:
        fd.writelines(reversed(out))


if __name__ == '__main__':
    main()
