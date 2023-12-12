@echo off
set SELF=%~n0

if [%1] == [-h] goto :usage
if [%1] == [--help] goto :usage

@echo ^taskkill /IM "wscript.exe" /F
taskkill /IM "wscript.exe" /F

goto :EOF
:usage
    echo usage: %SELF% [-h]
    echo  ^Kill ^wscript
    echo.
    echo    -h --help       Print this message
