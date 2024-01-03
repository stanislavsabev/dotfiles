@echo off
set SELF=%~n0
set SELF_DIR=%~dp0

if [%1] == [-h] goto :usage
if [%1] == [--help] goto :usage
if [%1] == [] goto :usage

cscript %SELF_DIR%\vbs_keepmeawake.vbs %*

goto :EOF
:usage
    echo usage: %SELF% [-h] HOURS [MINUTES]
    echo  Prevent Windows' sleep mode
    echo.
    echo    -h --help       Print this message
    echo    HOURS           0 - 15
    echo    MINUTES         0 - 60, optional
