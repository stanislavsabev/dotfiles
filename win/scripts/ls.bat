@echo off
SETLOCAL enableDelayedExpansion
set SELF=%~n0

:usage
    echo usage: %SELF% [-h] [-a] [-d] [-f]
    echo  List files and directory names starting with dot (.)
    echo.
    echo    -h --help  Print this message
    echo.
    echo    -a         Default. Lists files and directories
    echo    -d         Lists directories only
    echo    -f         Lists files only
    echo.
    GOTO:EOF

SET LONG=/B
SET ALL=0

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
        ) else if [!curOpt!] == [-l] (
            SET LONG=
        ) else if [!curOpt!] == [-a] (
            set ALL=1
        ) else if [!curOpt!] == [-la] (
            set ALL=1
            set LONG=
        ) else if [!curOpt!] == [-al] (
            set ALL=1
            set LONG=
        ) else (
            call :invalid_opt
            goto :EOF
        )
        shift
        goto :GETOPTS
    )
:ENDGETOPTS


ECHO   %*

:invalid_opt
    echo %SELF%: Invalid flag !curOpt!, see -h for usage
    exit /b 1

GOTO:EOF

