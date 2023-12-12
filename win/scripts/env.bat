@echo off
set SELF=%~n0

if [%1] == [-h] goto :usage
if [%1] == [--help] goto :usage

set


goto :EOF
:usage
    echo usage: %SELF% [-h]
    echo  Print environment variables
    echo.
    echo    -h --help       Print this message
