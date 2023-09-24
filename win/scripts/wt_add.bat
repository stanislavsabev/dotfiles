@echo off
SETLOCAL enableDelayedExpansion
set SELF=%~n0

SET ARGC=0
SET ARGV=

SET DRY=
SET EX=

:GETOPTS
    SET curOpt=%1
    SET curOpt1stChar=!curOpt:~0,1!

    rem The argument starts with -
    if [!curOpt1stChar!] == [-] (
        if [!curOpt!] == [-h] goto :usage
        if [!curOpt!] == [--help] goto :usage
        if [!curOpt!] == [-d] set DRY=1
        if [!curOpt!] == [--dry-run] set DRY=1
        if [!curOpt!] == [-x] set EX=1
        if [!curOpt!] == [--extended] set EX=1
        shift
        goto :GETOPTS
    )
    if not [!curOpt!] == [] (
        set /A ARGC+=1
        set ARGV[!ARGC!]=%1
        shift
        goto :GETOPTS
    )

if !ARGC! EQU 0 GOTO:invalid_args
if !ARGC! GTR 3 GOTO:invalid_args

rem Worktree command
set _CMD=git worktree add
call :dry

set ARGSTR=
if !ARGC! EQU 1 (
    set ARGSTR=!ARGV[1]!
)

if !ARGC! EQU 2 (
    set ARGSTR=-b !ARGV[1]! !ARGV[1]! !ARGV[2]!
)


if !ARGC! EQU 3 (
    set ARGSTR=-b !ARGV[1]! !ARGV[2]! !ARGV[3]!
)

!_CMD! !ARGSTR!

rem Extend command
IF DEFINED EX (
    SET TARGET_PATH=
    IF %ARGC% EQU 3 (
        SET TARGET_PATH=!ARGV[2]!
    ) else (
        SET TARGET_PATH=!ARGV[1]!
    )
    SET _CMD=xcopy /I /Y /E .vscode !TARGET_PATH!\.vscode
    call :dry
    !_CMD!
)

goto:EOF

:dry
    IF DEFINED DRY (
        set _CMD=echo dry-run: !_CMD!
    )
    exit /b 0

:invalid_args
    echo %SELF%: Invalid number of arguments %ARGC%, see -h for usage
    exit /b 1

:usage
    echo usage: %SELF% [-h] [-xd] [NEW_BRANCH] [PATH] COMMIT-ISH
    echo  Add worktree to current repository
    echo.
    echo    -h --help       Print this message
    echo    -z --extended   Extended options
    echo                    Copy helper directories (like .vscode) from parent ^dir
    echo    -d --dry-run    Print the command that would run
