@echo off

set VA=
if "%1"=="" (
    set VA=.\.venv
 ) else (
    set VA="%1%"
)

python -m venv %VA%
call %VA%\Scripts\activate.bat
