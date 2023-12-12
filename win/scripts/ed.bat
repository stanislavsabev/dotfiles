@echo off
set SELF=%~n0

if [%1] == [-h] goto :usage
if [%1] == [--help] goto :usage

%EDITOR% %*


goto :EOF
:usage
    echo usage: %SELF% [-h]
    echo  Open with default editor
    echo.
    echo    -h --help       Print this message
