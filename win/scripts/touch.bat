@echo off
set SELF=%~n0

if [%1] == [-h] goto :usage
if [%1] == [--help] goto :usage

echo. 2>%1

goto :EOF
:usage
    echo usage: %SELF% [-h] FILE
    echo  touch FILE
    echo.
    echo    -h --help       Print this message
