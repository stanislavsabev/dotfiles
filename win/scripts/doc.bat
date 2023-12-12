@echo off
set SELF=%~n0

if [%1] == [-h] goto :usage
if [%1] == [--help] goto :usage

pushd %USERPROFILE%\Documents

goto :EOF
:usage
    echo usage: %SELF% [-h]
    echo  Navigate to documents
    echo.
    echo    -h --help       Print this message
