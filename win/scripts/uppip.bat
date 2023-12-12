@echo off
set SELF=%~n0

if [%1] == [-h] goto :usage
if [%1] == [--help] goto :usage

python -m pip install --upgrade pip

goto :EOF
:usage
    echo usage: %SELF% [-h]
    echo  Upgrade pip
    echo.
    echo    -h --help       Print this message
