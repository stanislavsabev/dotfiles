@echo off
set SELF=%~n0

if [%1] == [-h] goto :usage
if [%1] == [--help] goto :usage

cls

goto :EOF
:usage
    echo usage: %SELF% [-h]
    echo  Clear terminal
    echo.
    echo    -h --help       Print this message
