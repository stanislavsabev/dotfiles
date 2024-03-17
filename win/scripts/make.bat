@REM ## Helper script similar to make
set @echo off
SETLOCAL enableDelayedExpansion
set SELF=%~n0
set SELF_DIR=%~dp0

set SELF_COLORED=[90m%SELF%[0m

SET DEBUG=echo %SELF_COLORED% [36m[DEBUG][0m:
SET DEBUG=
SET INFO=echo %SELF_COLORED% [94m[DEBUG][0m:
SET WARN=echo %SELF_COLORED% [33m[DEBUG][0m:
SET ERR=echo %SELF_COLORED% [31m[DEBUG][0m:

!DEBUG! "Global make file"

SET PIP_CONFIG_FILE=pip.conf
SET REQUIREMENTS_DIR=.\requirements

SET SRC_=src

SET CMD_NAME=
SET CMD_DOC=
CALL :define_commands
if [%1] == [] goto :usage



:usage
  echo usage: %SELF% [-h] SCRIPT ^| COMMAND [FLAGS]
  echo   Manage tasks in a way similar to make
  echo.
  echo   [90m-h --help[0m       Prints this message
  echo.
  call :print_commands
goto :EOF

@REM Commands

:format
    call :activate-venv
    !INFO! ruff ^format
    ruff ^format .
    ruff check --fix .
    exit /b 0

:check
    call :activate-venv
    !INFO! mypy
    mypy %SRC_%
    exit /b 0

:checkall
    call :format
    call :check
    exit /b 0

:req-update
    call :activate-venv
    IF %ERRORLEVEL% NEQ 0 goto :EOF
    call :req-install
    exit /b 0

:req-install
    pushd %SELF_DIR%
    pip-sync %REQUIREMENTS_DIR%\requirements.txt %REQUIREMENTS_DIR%\requirements-dev.txt
    if ["!PROJ_TYPE!"] == ["package"] (
        pip install -e .
    )
    pre-commit install
    popd
    exit /b 0

:req-compile
    set UPGRADE=
    if ["%CMD_ARGS%"] == ["-u"] SET UPGRADE=--upgrade
    if ["%CMD_ARGS%"] == ["--upgrade"] SET UPGRADE=--upgrade
    pip-compile %UPGRADE% %REQUIREMENTS_DIR%\requirements.in
    pip-compile %UPGRADE% %REQUIREMENTS_DIR%\requirements-dev.in
    exit /b 0

:activate-venv
    IF DEFINED VENV_ACTIVATED (
        !INFO! "'%VENV_PATH%' already activated"
        exit /b 0
    )
    if not DEFINED VENV_PATH (
        !ERR! "VENV_PATH is not defined"
        goto :EOF
    )
    
    IF NOT EXIST %VENV_PATH%\ (
        !ERR! "Cannot find environment with name '%VENV_PATH%'"
        exit /b 1
    )
    call %VENV_PATH%\Scripts\activate
    set VENV_ACTIVATED=1
    exit /b 0

:create-venv
    IF EXIST %VENV_PATH%\ (
        !WARN! Environment '%VENV_PATH%' already exists
        exit /b 1
    )

    !INFO! Create %VENV_PATH%
    python -m venv %VENV_PATH%
    call %VENV_PATH%\Scripts\activate
    python -m pip install --upgrade pip
    python -m pip install pip-tools
    exit /b 0

:delete-venv
    IF NOT EXIST %VENV_PATH%\ (
        !WARN! %VENV_PATH% ^not found
        exit /b 1
    )
    IF EXIST %VENV_PATH%\Scripts\deactivate.bat (
        call %VENV_PATH%\Scripts\deactivate.bat
    )
    rd /S /q %VENV_PATH%

    IF EXIST %VENV_PATH% (
        !ERR! Removing environment %VENV_PATH% failed. Remove it manually
        exit /b 1
    )
    exit /b 0

:collect
    pytest --collect-only tests
    exit /b 0

:cov
    set COV_INDEX=%SELF_DIR%build\htmlcov\index.html
    IF EXIST %COV_INDEX% (
        start     %COV_INDEX%
        @REM  ^^^ insert browser hare
    ) ELSE (
        !ERR! "Cannot find coverage file '%COV_INDEX%'"
    )
    exit /b 0

:test
    call :activate-venv
    pytest tests -v --cov=src --cov-report=term --cov-report=html:build/htmlcov --cov-report=xml --cov-fail-under=80
    exit /b 0

:clean
    set CACHE_DIRS=.mypy_cache .pytest_cache .ruff_cache build
    set CACHE_FILES=.cache

    !INFO! Removing cache dirs
    FOR /d %%d IN (%CACHE_DIRS%) DO (
        IF EXIST ".\%%d\" rd /S /q "%%d"
        IF %ERRORLEVEL% NEQ 0 (
            !ERR! "Removing .\%%d failed. Remove it manually"
        )
    )
    FOR %%f IN (%CACHE_FILES%) DO (
        IF EXIST "%%f" del /q "%%f"
        IF %ERRORLEVEL% NEQ 0 (
            !ERR! "Removing file '%%f' failed. Remove it manually"
        )
    )
    FOR /d /r . %%d IN (__pycache__) DO (
        IF EXIST "%%d\" rd /S /q "%%d"
    )
    exit /b 0

:gh
    start     "https://github.com/stanislavsabev/%PROJ_NAME%"
    @REM  ^^^ insert browser hare


:setup
    set SRC_PATH=
    IF "%CMD_ARGS%" == "" (
        SET SRC_PATH=..
    ) ELSE (
        SET SRC_PATH="%CMD_ARGS%"
    )
    !DEBUG! SRC_PATH: !SRC_PATH!

    IF NOT EXIST %SRC_PATH%\ (
        !ERR! "Cannot find setup source '!SRC_PATH!'"
    )

    FOR %%F IN (.proj-cfg .python-cfg) (
        IF EXIST "%SRC_PATH%\%%F" (
            fcopy /Y "%SRC_PATH%\%%F" "%%F"
        )
    )