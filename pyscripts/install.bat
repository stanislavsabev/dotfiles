@REM @echo off
SETLOCAL enableDelayedExpansion
set SELF_DIR=%~dp0

IF EXIST %SELF_DIR%.venv\ (
    echo %SELF_DIR%.venv\ already exists
    goto :EOF
)

python -m venv %SELF_DIR%\.venv^
     && call %SELF_DIR%\.venv\Scripts\activate.bat^
     && pip install -r %SELF_DIR%\requirements.txt