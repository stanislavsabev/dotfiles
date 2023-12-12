@echo off
set SELF=%~n0

if [%1] == [-h] goto :usage
if [%1] == [--help] goto :usage


cd %PROJECTS_DIR%\win-caffeine
CALL ".\.venv\Scripts\activate.bat"
"python" "win-caffeine.py"

goto :EOF
:usage
    echo usage: %SELF% [-h]
    echo  Run win-caffeine
    echo.
    echo    -h --help       Print this message
