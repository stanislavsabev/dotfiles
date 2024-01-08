@echo off
set SELF=%~n0

if [%1] == [-h] goto :usage
if [%1] == [--help] goto :usage

pushd %DOTFILES_DIR%

goto :EOF
:usage
    echo usage: %SELF% [-h]
    echo  Navigate to dotfiles
    echo.
    echo    -h --help       Print this message
