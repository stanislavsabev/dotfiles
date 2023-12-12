@echo off
set SELF=%~n0

if [%1] == [-h] goto :usage
if [%1] == [--help] goto :usage

echo D| xcopy %*

goto :EOF
:usage
    echo usage: %SELF% [-h] FILE
    echo  Alias for echo D^| ^xcopy ARGS...
    echo.
    echo    -h --help       Print this message
