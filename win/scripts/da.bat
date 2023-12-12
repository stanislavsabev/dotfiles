@echo off
set SELF=%~n0

if [%1] == [-h] goto :usage
if [%1] == [--help] goto :usage

deactivate

goto :EOF
:usage
    echo usage: %SELF% [-h]
    echo  Deactivate virtual environment
    echo.
    echo    -h --help       Print this message
