@echo off
set SELF=%~n0

if [%1] == [-h] goto :usage
if [%1] == [--help] goto :usage

pushd %USERPROFILE%

goto :EOF
:usage
    echo usage: %SELF% [-h]
    echo  Navigate to USERPROFILE
    echo.
    echo    -h --help       Print this message
