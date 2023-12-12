@echo off
set SELF=%~n0

if [%1] == [-h] goto :usage
if [%1] == [--help] goto :usage

pushd %USERPROFILE%\Downloads

goto :EOF
:usage
    echo usage: %SELF% [-h]
    echo  Navigate to downloads
    echo.
    echo    -h --help       Print this message
