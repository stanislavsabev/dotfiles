@echo off
set SELF=%~n0

if [%1] == [-h] goto :usage
if [%1] == [--help] goto :usage

set VA=
if "%1"=="" (
    set VA=%VENV_NAME%
 ) else (
    set VA="%1"
)

python -m venv %VA%
call %VA%\Scripts\activate.bat
