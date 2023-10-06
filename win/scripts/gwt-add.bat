@echo off
SETLOCAL enableDelayedExpansion
set SELF=%~n0

SET ARGC=0
SET ARGV=

SET DRY=
SET EX=

if [%1] == [] (
   goto:invalid_args
)

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
        ) else if [!curOpt!] == [-x] (
            set EX=1
        ) else if [!curOpt!] == [--extended] (
            set EX=1
        ) else (
            goto :invalid_opt
        ) 
        shift
        goto :GETOPTS
    )
    @rem Positional arguments
    if not [!curOpt!] == [] (
        set /A ARGC+=1
        set ARGV[!ARGC!]=%1
        shift
        goto :GETOPTS
    )
:ENDGETOPTS

if !ARGC! EQU 0 GOTO:invalid_args
if !ARGC! GTR 3 GOTO:invalid_args

@rem Worktree command
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

@rem Run git worktree command
!_CMD! !ARGSTR!

@rem Extend command
IF DEFINED EX (
    SET TARGET_PATH=
    IF %ARGC% EQU 3 (
        SET TARGET_PATH=!ARGV[2]!
    ) else (
        SET TARGET_PATH=!ARGV[1]!
    )
    SET _CMD=xcopy /I /Y /E .vscode !TARGET_PATH!\.vscode
    call :dry
    @rem Run extended commands 
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

:invalid_opt
    echo %SELF%: Invalid flag !curOpt!, see -h for usage

:usage
    echo usage: %SELF% [-h] [-x] [-d] [NEW_WORKTREE] [[PATH] COMMIT-ISH]
    echo  Add worktree to current repository
    echo.
    echo    -h --help       PrintS this message
    echo    -z --extended   Extended options
    echo                    Copy helper directories (like .vscode) from parent ^dir
    echo    -d --dry-run    Print the command that would run
