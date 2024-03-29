@echo off
SETLOCAL enableDelayedExpansion
set SELF=%~n0

SET ARGC=0
SET NAMES=
SET DRY=
SET FORCE=
SET PAT=

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
        ) else if [!curOpt!] == [-n] (
            set DRY=1
        ) else if [!curOpt!] == [--dry-run] (
            set DRY=1
        ) else if [!curOpt!] == [-f] (
            set FORCE=--force
        ) else if [!curOpt!] == [--force] (
            set FORCE=--force
        ) else if [!curOpt!] == [-p] (
            set PAT=1
        ) else if [!curOpt!] == [--pattern] (
            set PAT=1
        ) else (
            goto :invalid_opt
        ) 
        shift
        goto :GETOPTS
    )
    if not [!curOpt!] == [] (
        set /A ARGC+=1
        set NAMES[!ARGC!]=%1
        shift
        goto :GETOPTS
    )
:ENDGETOPTS

if !ARGC! EQU 0 GOTO:invalid_args

@rem Remove worktree command
set _CMD=git worktree remove
call :dry
set RM_WT_CMD=!_CMD!

@REM Delete branch command
SET _CMD=^git branch -D
call :dry
set RM_BRANCH_CMD=!_CMD!

for /L %%i in ( 1,1,!ARGC! ) do (
    IF DEFINED PAT (
        echo %SELF%: Pattern not implemented yet
        exit /b 1
    ) else (
        !RM_WT_CMD! %FORCE% !NAMES[%%i]!
        !RM_BRANCH_CMD! !NAMES[%%i]!
    )
)

goto:EOF

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
    exit /b 1

:usage
    echo usage: %SELF% [-h] [-n] [-f] [-p] NAMES
    echo  Remove worktree
    echo.
    echo    -h --help       Print this message
    echo    -n --dry-run    Print the command that would run
    echo    -f --force      Force remove, even if worktree is dirty of locked
    echo    NOTE: Pattern not implemented yet
    echo    -p --pattern FINDSTR [FLAGS] STASHED
    echo                    Use patterns to match and remove
