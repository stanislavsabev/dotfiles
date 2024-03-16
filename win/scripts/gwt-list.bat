@echo off
SETLOCAL enableDelayedExpansion
set SELF=%~n0

SET FLAGS=
SET PATTERN=
SET ARGC=0
SET VERBOSE=

:GETOPTS
    if [%1] == [] (
        goto :ENDGETOPTS
    )
    SET curOpt=%1
    SET curOpt1stChar=!curOpt:~0,1!

    @rem Flags
    if [!curOpt1stChar!] == [-] (
        if [!curOpt!] == [-h] (
            goto :usage
        ) else if [!curOpt!] == [--help] (
            goto :usage
        ) else if [!curOpt!] == [-n] (
            set DRY=1
        ) else if [!curOpt!] == [-v] (
            set VERBOSE=1
        )
        shift
        goto :GETOPTS
    ) else if [!curOpt1stChar!] == [/] (
        set FLAGS=!FLAGS! %1
        shift
        goto :GETOPTS
    ) else if not [!curOpt!] == [] (
        @rem Set PATTERN = first non flag argument
        IF not DEFINED PATTERN (
            set PATTERN=!curOpt!
            shift
        )
        goto :GETOPTS
    )
:ENDGETOPTS

SET _CMD=git worktree list

if defined PATTERNS (
    set _CMD=!_CMD! ^| ^FINDSTR !FLAGS! "%PATTERNS%"
)

if ["!VERBOSE!"] == ["1"] (
    FOR /f "tokens=*" %%a in ('!_CMD!') DO (
        echo %%a
    )
) else (
    FOR /f "tokens=1,2,3 delims= " %%a in ('!_CMD!') DO (
        if not ["%%b"] == ["(bare)"] (
            echo %%b %%c
        )
    )
)

goto:EOF

:usage
    echo usage: %SELF% [-h] [-v] [[FLAGS] PATTERN]
    echo  List worktrees in current repo
    echo.
    echo    -h --help       Print this message
    echo    -v --verbose    Verbose format
    echo    FLAGS           Flags for FINDSTR 
    echo    PATTERN         Pattern to match
