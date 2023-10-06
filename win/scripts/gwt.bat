@echo off
SETLOCAL enableDelayedExpansion
set SELF=%~n0

if [%1] == [] (
   echo %SELF%: Missing command, see -h for usage
   exit /b 1
)

set curOpt=%1
shift
SET REST_OPTS=
:get_args
    if [%1] == [] goto :end_get_args
    set REST_OPTS=%REST_OPTS% %1
    shift
    goto :get_args
:end_get_args

set _CMD=

IF [!curOpt!] == [-h] goto :usage
IF [!curOpt!] == [--help] goto :usage

IF [!curOpt!] == [add] set _CMD=gwt-add
IF [!curOpt!] == [a] set _CMD=gwt-add
IF [!curOpt!] == [checkout] set _CMD=gwt-checkout
IF [!curOpt!] == [co] set _CMD=gwt-checkout
IF [!curOpt!] == [list] set _CMD=gwt-list
IF [!curOpt!] == [ls] set _CMD=gwt-list
IF [!curOpt!] == [move] set _CMD=gwt-move
IF [!curOpt!] == [mv] set _CMD=gwt-move
IF [!curOpt!] == [remove] set _CMD=gwt-remove
IF [!curOpt!] == [rm] set _CMD=gwt-remove
IF [!curOpt!] == [clone] set _CMD=gwt-clone

IF DEFINED _CMD (
    shift
    call %_CMD% %REST_OPTS%
    exit /b 0
) else (
    echo %SELF%: Unknown command `!curOpt!`, see -h for usage
    exit /b 1
)

:usage
    echo usage: %SELF% [-h] COMMAND [COMMAND_ARGS...]
    echo  Call worktree command
    echo.
    echo    -h --help       PrintS this message
    echo.
    echo    COMMAND         Supported commands:
    echo        add      ^| a  - Add worktree
    echo        checkout ^| co - Not implemented
    echo        list     ^| ls - List worktrees
    echo        move     ^| mv - ^Rename worktree
    echo        remove   ^| rm - Remove worktree
    echo        clone    ^|    - Clone remote and setup bare repo
    echo.
