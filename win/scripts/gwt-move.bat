@echo off
SETLOCAL enableDelayedExpansion
set SELF=%~n0

SET ARGC=0
SET DRY=

if [%1] == [] (
   goto:invalid_args
)

:GETOPTS
    SET curOpt=%1
    SET curOpt1stChar=!curOpt:~0,1!

    rem The argument starts with -
    if [!curOpt1stChar!] == [-] (
        if [!curOpt!] == [-h] goto :usage
        if [!curOpt!] == [--help] goto :usage
        if [!curOpt!] == [-d] set DRY=1
        if [!curOpt!] == [--dry-run] set DRY=1
        shift
        goto :GETOPTS
    )
    if not [!curOpt!] == [] (
        set /A ARGC+=1
        set ARGV[!ARGC!]=%1
        shift
        goto :GETOPTS
    )

IF !ARGC! NEQ 2 (
   goto:invalid_args
)

rem Move Worktree command
set _CMD=git worktree move !ARGV[1]! !ARGV[2]!
call :dry
!_CMD!


rem Rename branch command
set _CMD=cd !ARGV[2]! ^&^& git branch -M !ARGV[2]!
call :dry
!_CMD!

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
    echo usage: %SELF% [-h] [-d] WORKTREE NEW_WORKTREE
    echo  Rename worktree
    echo.
    echo    -h --help       Prints this message
    echo    -d --dry-run    Print the command that would run
