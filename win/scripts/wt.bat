@echo off
SETLOCAL enableDelayedExpansion
set SELF=%~n0

if [%1] == [] (
    echo %SELF%: Missing command, see -h for usage
    exit /b
)

set curOpt=%1
shift
set REST_OPTS=
:get_args
    if [%1] == [] goto end_get_args
    set REST_OPTS=%REST_OPTS% %1
    shift
    GOTO get_args
:end_get_args

SET _CMD=

IF [!curOpt!] == [-h] goto :usage
IF [!curOpt!] == [--help] goto :usage

IF [!curOpt!] == [add] set _CMD=wt_add
IF [!curOpt!] == [a] set _CMD=wt_add
IF [!curOpt!] == [checkout] set _CMD=wt_checkout
IF [!curOpt!] == [c] set _CMD=wt_checkout
IF [!curOpt!] == [list] set _CMD=wt_list
IF [!curOpt!] == [ls] set _CMD=wt_list
IF [!curOpt!] == [move] set _CMD=wt_move`
IF [!curOpt!] == [mv] set _CMD=wt_move`
IF [!curOpt!] == [remove] set _CMD=wt_remove
IF [!curOpt!] == [rm] set _CMD=wt_remove

IF DEFINED _CMD (
    shift
    call %_CMD% %REST_OPTS%
    exit /b 0
) else (
    echo %SELF%: Unknown command `!curOpt!`, see -h for usage
    exit /b 1
)

:usage
    echo usage: %SELF% [-h] [COMMAND] [COMMAND_ARGS...]
    echo  Call worktree command
    echo.
    echo    -h --help       PrintS this message
    echo.
    echo    COMMAND         Supported commands:
    echo        add      ^| a
    echo        checkout ^| co
    echo        list     ^| ls
    echo        move     ^| mv
    echo        remove   ^| rm
