@echo off
set SELF=%~n0

if [%1] == [-h] goto :usage
if [%1] == [--help] goto :usage

@echo ^taskkill /IM "cscript.exe" /F
taskkill /IM "cscript.exe" /F

goto :EOF
:usage
    echo usage: %SELF% [-h]
    echo  ^Kill ^cscript
    echo.
    echo    -h --help       Print this message
