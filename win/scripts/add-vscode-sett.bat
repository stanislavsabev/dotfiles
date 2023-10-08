@echo off
SETLOCAL enableDelayedExpansion
set SELF=%~n0

SET DRY=
SET REV=

:GETOPTS
    if [%1] == [] goto :ENDGETOPTS
    SET curOpt=%1
    SET curOpt1stChar=!curOpt:~0,1!

    @rem Flags
    if [!curOpt1stChar!] == [-] (
        if [!curOpt!] == [-h] (
            goto :usage
        ) else if [!curOpt!] == [--help] (
            goto :usage
        ) else if [!curOpt!] == [-d] (
            set DRY=1
        ) else if [!curOpt!] == [--dry-run] (
            set DRY=1
        ) else if [!curOpt!] == [-r] (
            set REV=1
        ) else if [!curOpt!] == [--reverse] (
            set REV=1
        ) else (
            goto :invalid_opt
        )
        shift
        goto :GETOPTS
    )

    @rem Positional arguments
    if not [!curOpt!] == [] (
        IF DEFINED SRC_PATH goto:invalid_args
        set SRC_PATH="!curOpt!"
        shift
        goto :GETOPTS
    )
:ENDGETOPTS

IF not DEFINED SRC_PATH SET SRC_PATH=..
SET SRC=%SRC_PATH%\.vscode
SET DEST=.vscode

IF DEFINED REV (
    SET TMP_=!SRC!
    SET SRC=!DEST!
    SET DEST=!TMP_!
)

SET _CMD=xcopy /I /Y /E !SRC! !DEST!
call :dry
!_CMD!

goto:EOF

@rem Prepend command with echo if DRY is defined
:dry
    IF DEFINED DRY (
        set _CMD=echo dry-run: !_CMD!
    )
    exit /b 0

:invalid_args
    echo %SELF%: Invalid arguments, see -h for usage
    exit /b 1

:invalid_opt
    echo %SELF%: Invalid flag !curOpt!, see -h for usage

:usage
    echo usage: %SELF% [-h] [-r] [-d] [PATH]
    echo  Copy the .vscode/ settings directory
    echo.
    echo    -h --help       Prints this message
    echo    -r --reverse    Reverse copy
    echo    -d --dry-run    Print the command that would run
