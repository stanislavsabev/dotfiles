@echo off
set SELF=%~n0

if [%1] == [-h] goto :usage
if [%1] == [--help] goto :usage

type %*

goto :EOF
:usage
    echo usage: %SELF% [-h] FILE
    echo  cat FILE
    echo.
    echo    -h --help       Print this message
