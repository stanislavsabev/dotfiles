@echo off
set SELF=%~n0

if [%1] == [-h] goto :usage
if [%1] == [--help] goto :usage
if [%1] == [] goto :usage

if not exist %1 (
    echo %SELF%: Cannot find file "%1"
    goto :EOF
)

for /F "tokens=*" %%i in (%1) do (
    code --install-extension %%i
)

goto :EOF
:usage
    echo usage: %SELF% [-h] FILE
    echo  Install VSCode extensions from file
    echo.
    echo    -h --help       Print this message
