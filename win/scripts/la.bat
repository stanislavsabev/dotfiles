@echo off
set SELF=%~n0

if [%1] == [-h] goto :usage
if [%1] == [--help] goto :usage

dir /A %*

goto :EOF
:usage
    echo usage: %SELF% [-h] [DIRNAME]
    echo  ls -l DIRNAME
    echo.
    echo    -h --help       Print this message
