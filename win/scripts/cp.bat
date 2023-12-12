@echo off
set SELF=%~n0

if [%1] == [-h] goto :usage
if [%1] == [--help] goto :usage

xcopy %*

goto :EOF
:usage
    echo usage: %SELF% [-h] FILE
    echo  Alias for xcopy
    echo.
    echo    -h --help       Print this message
