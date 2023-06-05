@echo off

cd %PROJECTS_DIR%\win-caffeine
CALL ".\.venv\Scripts\activate.bat"
"python" "win-caffeine.py"
