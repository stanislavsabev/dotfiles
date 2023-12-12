@echo off
SETLOCAL enableDelayedExpansion
set SELF=%~n0

SET FLAGS=
SET PATTERNS=
SET ARGC=0

:GETOPTS
    if [%1] == [] (
        goto:end_get_args
    )

    SET curOpt=%1
    SET curOpt1stChar=!curOpt:~0,1!

    rem The argument starts with -
    if [!curOpt1stChar!] == [-] (
        if [!curOpt!] == [-h] goto :usage
        if [!curOpt!] == [--help] goto :usage

        set FLAGS=!FLAGS! %1

        shift
        goto :GETOPTS
    )
    @rem Set PATTERNS = first non flag argument
    if not [!curOpt!] == [] (
        IF !ARGC! EQU 0 (
            set /A ARGC+=1
            set PATTERNS=!curOpt!
            shift
        )
        goto :GETOPTS
    )

:end_get_args

SET _CMD=git worktree list

if defined PATTERNS (
    set _CMD=!_CMD! ^| ^FINDSTR !FLAGS! "%PATTERNS%"
)

FOR /f "tokens=2 delims=[" %%i in ('!_CMD!') DO (
    echo ^[%%i
)

goto:EOF

:usage
    echo usage: %SELF% [-h] [[FLAGS] PATTERNS]
    echo  List worktrees in current repo
    echo.
    echo    -h --help       Print this message
    echo    FLAGS           FINDSTR flags
    echo    PATTERNS        PATTERNS to match
