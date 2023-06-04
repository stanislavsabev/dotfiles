@echo off

set VA=
if "%1"=="" (
    set VA=.\.venv
 ) else (
    set VA="%1%"
)

%VA%\Scripts\activate.bat