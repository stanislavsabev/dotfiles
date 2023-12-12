@echo off
set SELF=%~n0

if [%1] == [-h] goto :usage
if [%1] == [--help] goto :usage

echo F| xcopy %*

goto :EOF
:usage
    echo usage: %SELF% [-h] FILE
    echo  Alias for echo F^| ^xcopy ARGS...
    echo.
    echo    -h --help       Print this message
