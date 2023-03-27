#!/usr/bin/env python3

"""
Verifies that the commit message meets the guidelines.
"""

import sys
import re
from typing import List


DEFAULT = "\033[0m"
GREEN = "\033[6;30;42m"
RED_BG = "\033[41m"
RED_FG = "\033[91m"
BOLD = "\033[1m"

_MIN_LINE_LENGTH = 1

_MAX_BODY_LINES = 20

_SUBJECT_LENGTH_LIMIT = 50

_BODY_LINE_LENGTH_LIMIT = 72

_SUBJECT_REGEX = re.compile(r"[A-Z][\S ]+[^.]")

_BODY_FIRST_LINE_REGEX = re.compile(r"[A-Z\-*][\S ]+")

_BODY_FOLLOWING_LINES_REGEX = re.compile(r"[A-Za-z\-*][\S ]+")

_ISSUE_LINES_REGEX = re.compile(r"Issue: http://b/\d+")

_CHANGE_ID_LINE_REGEX = re.compile(r"Change-Id: \S+")


def verify(msg: str) -> List[str]:
    """
    Commit message requirements:

    1. Separate subject from body with a blank line
    2. Limit the subject line to 50 characters
    3. Capitalize the subject line
    4. Do not end the subject line with a period
    5. Use the imperative mood in the subject line (spoken or written
        as if giving a command or instruction)
    6. Don't prefix subject line with the application name (e.g. [Auditor],
    [Manager], etc.)
    7. There should be at most 20 lines
    8. Wrap each line in 72 characters
    9. Use the body to explain what and why vs. how
    10. The last line of the message should be of the form
      Issue: http://b/<issue number>

    Args:
      msg: The commit message to be verified
    """
    violations = []
    try:
        lines, change_id_line = msg.rstrip("\n").rsplit("\n", 1)
        subject_line, body_section, issues_section = lines.split("\n\n")
    except ValueError:
        return [
            "Wrong message format. Message format: Subject, empty line, "
            "Body, empty line, Issues and Change-Id"
        ]
    body_lines = body_section.split("\n")
    issues_lines = issues_section.split("\n")

    if not re.fullmatch(_SUBJECT_REGEX, subject_line):
        violations.append("Wrong subject format")

    if not _MIN_LINE_LENGTH <= len(subject_line) <= _SUBJECT_LENGTH_LIMIT:
        violations.append(f"Wrong subject length: {len(subject_line)}")

    if not 1 <= len(body_lines) <= _MAX_BODY_LINES:
        violations.append("Too many body lines")

    for line_n, body_line in enumerate(body_lines):
        if not re.fullmatch(
            _BODY_FOLLOWING_LINES_REGEX if line_n else _BODY_FIRST_LINE_REGEX,
            body_line,
        ):
            violations.append(f"Wrong body line #{line_n + 1} format")

        if not _MIN_LINE_LENGTH <= len(body_line) <= _BODY_LINE_LENGTH_LIMIT:
            violations.append(
                f"Wrong body line #{line_n + 1} length: " f"{len(body_line)}"
            )

    for line_n, issue_line in enumerate(issues_lines):
        if not re.fullmatch(_ISSUE_LINES_REGEX, issue_line):
            violations.append(f"Wrong Issue line #{line_n + 1} format")

    if not re.fullmatch(_CHANGE_ID_LINE_REGEX, change_id_line):
        violations.append("Wrong Change-Id format")
    return violations


def main():
    """Entry point for this script"""

    if len(sys.argv) > 1:
        msg = sys.argv[1]
    else:
        print(f"{RED_BG}Failed. Please enter commit message.{DEFAULT}")
        return 0

    print("Commit message: " + "\n" + msg)
    violations = verify(msg)
    if not violations:
        print(f"{GREEN}Done. Commit message is valid!{DEFAULT}")
        return 0
    print(
        f"{RED_BG}Failed.{DEFAULT}"
        + f"{RED_FG} Commit message is incorrect.\n"
        + f"Violations: {violations}\n"
        + f"{DEFAULT}"
        + "Please refer to the message guide."
        + "\n"
        + f"{BOLD}"
        "go/commitmsg" + f"{DEFAULT}"
    )
    return 1


if __name__ == "__main__":
    sys.exit(main())
