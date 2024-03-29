@REM ## Helper script similar to make
@echo off
SETLOCAL enableDelayedExpansion
SET SELF=%~n0
SET SELF_DIR=%~dp0
SET SELF_COLORED=[90m%SELF%[0m

SET DEBUG=echo %SELF_COLORED% [36mDEBUG[0m:
@REM SET DEBUG=
SET INFO=echo %SELF_COLORED% [94mINFO[0m:
SET WARN=echo %SELF_COLORED% [33mWARN[0m:
SET WARNING=%WARN%
SET ERR=echo %SELF_COLORED% [31mERR[0m:

!DEBUG! "Global make file"

SET REQUIREMENTS_DIR=.\requirements

SET PROJ_CFG=.proj-cfg
SET SRC_=src

SET CMD_NAME=
SET CMD_DOC=
call :define_commands
if [%1] == [] goto :USAGE

:GETOPTS
    !DEBUG! "GETOPTS"
    if [%1] == [] goto :ENDGETOPTS
    SET curOpt=%1
    SET curOpt1stChar=!curOpt:~0,1!

    @rem Flags
    if [!curOpt1stChar!] == [-] (
        if [!curOpt!] == [-h] goto :USAGE
        if [!curOpt!] == [--help] goto :USAGE
        !ERR! "Unexpected option or flag !curOpt!, see -h for usage"
        exit /b 1
    ) else (
        @rem Command
        call :match_command
        IF %ERRORLEVEL% NEQ 0 (
            !ERR! "Unknown command or script '!curOpt!', see -h for usage"
        ) ELSE (
            goto :ENDGETOPTS
        )
    )

:ENDGETOPTS
!DEBUG! "ENDGETOPTS"

SET CMD_ARGV=
SET /A CMD_ARGC=0
!DEBUG! "GET_CMD_OPTS"
:GET_CMD_OPTS
    shift
    if "%1"=="" goto :END_GET_CMD_OPTS
    if DEFINED CMD_ARGV (
        SET CMD_ARGV=!CMD_ARGV! %1
    ) ELSE (
        SET CMD_ARGV=%1
    )
    SET /A CMD_ARGC += 1
    goto :GET_CMD_OPTS
:END_GET_CMD_OPTS
!DEBUG! "END_GET_CMD_OPTS"
!DEBUG! "CMD_ARGC: !CMD_ARGC!, CMD_ARGV: '%CMD_ARGV%'"

:: Process a command
if DEFINED CMD_NAME (
    !DEBUG! " ENTER ':!CMD_NAME!', DOC: '!CMD_DOC!'"
    call :!CMD_NAME!
    !DEBUG! "  EXIT ':!CMD_NAME!', ERRORLEVEL: '!ERRORLEVEL!'"
) ELSE (
    !ERR! "None of the commands match '!curOpt!'"
)

!DEBUG! "goto :EOF"
goto :EOF

:read_proj_cfg
    if DEFINED PROJ_CFG_LOADED (
        !INFO! "%PROJ_CFG% already loaded"
        exit /b 0
    )
    SET PROJ_CFG_LOADED=
    IF NOT EXIST "%CD%\%PROJ_CFG%" (
        !ERR! "Missing '%PROJ_CFG%' file"
        exit /b 1
    )
    call envsource %PROJ_CFG%
    set PROJ_CFG_LOADED=1
    exit /b 0

:print_commands
    !DEBUG! " ENTER :print_commands"

    echo     COMMANDS
    FOR /L %%i IN (1,1,!N_CMD!) DO (
        set ALIGN=            !CMDV[%%i]!
        echo [90m!ALIGN:~-12![0m  !DOCV[%%i]!
    )
    !DEBUG! "  EXIT :print_commands"
    exit /b 0

:match_command
    !DEBUG! " ENTER :match_command"
    FOR /L %%i IN (1,1,!N_CMD!) DO (
        if "!curOpt!" == "!CMDV[%%i]!" (
            !DEBUG! "  Matched :!curOpt!"
            set CMD_NAME=!curOpt!
            set CMD_DOC=!DOCV[%%i]!
            !DEBUG! "  EXIT :match_command"
            exit /b 0
        )

    )
    !DEBUG! "  EXIT :match_command, error 1"
    exit /b 1

:USAGE
  echo usage: %SELF% [-h] SCRIPT ^| COMMAND [FLAGS]
  echo   Manage tasks in a way similar to make
  echo    [90m-h --help[0m        Prints this message
  echo.
  call :print_commands
goto :EOF

@REM Commands

:format
    !INFO! "ruff format"
    ruff ^format .
    ruff check --fix .
    exit /b 0

:check
    call :read_proj_cfg
    if not DEFINED PROJ_SRC (
        SET PROJ_SRC=%SRC_%
    )
    !INFO! "mypy"
    mypy %PROJ_SRC%
    exit /b 0

:checkall
    call :format
    call :check
    exit /b 0

:build
    !INFO! Check all and run tests
    call :checkall
    call :test
    exit /b 0

:req-update
    call :activate_venv
    IF %ERRORLEVEL% NEQ 0 goto :EOF
    call :req-install
    exit /b 0

:req-compile
    set UPGRADE=
    if ["%CMD_ARGV%"] == ["-u"] SET UPGRADE=--upgrade
    if ["%CMD_ARGV%"] == ["--upgrade"] SET UPGRADE=--upgrade

    call :read_proj_cfg
    call :activate_venv
    call :set_pip_conf
    pip-compile %UPGRADE% %REQUIREMENTS_DIR%\requirements.in
    pip-compile %UPGRADE% %REQUIREMENTS_DIR%\requirements-dev.in
    exit /b 0

:req-install
    call :read_proj_cfg
    call :activate_venv
    call :set_pip_conf
    pip-sync %REQUIREMENTS_DIR%\requirements.txt %REQUIREMENTS_DIR%\requirements-dev.txt
    if ["!PROJ_TYPE!"] == ["package"] (
        pip install -e .
    )
    pre-commit install
    exit /b 0

:activate_venv
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
        goto :EOF
    )
    call %VENV_PATH%\Scripts\activate
    !DEBUG! "Activated '%VENV_PATH%'"
    set VENV_ACTIVATED=1
    exit /b 0

:set_pip_conf
    if DEFINED PIP_CONFIG_FILE exit /b 0

    IF EXIST "pip.conf" (
        !INFO! "SET PIP_ CONFIG_FILE=pip.conf"
        SET PIP_ CONFIG_FILE=pip.conf
    )
    exit /b 0

:create-venv
    call :read_proj_cfg
    if not DEFINED VENV_PATH (
        !ERR! "Missing env variable 'VENV_PATH'"
        exit /b 1
    )
    !DEBUG! "CD: %CD% VENV_PATH: %VENV_PATH%"
    IF EXIST %VENV_PATH%\ (
        !WARN! "Environment '%VENV_PATH%' already exists"
        exit /b 1
    )

    call :set_pip_conf
    !INFO! "Create %VENV_PATH%"
    python -m venv %VENV_PATH%
    call :activate_venv
    !DEBUG! "Upgrade pip and install pip-tools"
    python -m pip install --upgrade pip
    python -m pip install pip-tools
    exit /b 0

:delete-venv
    call :read_proj_cfg
    IF NOT EXIST %VENV_PATH%\ (
        !WARN! "%VENV_PATH% not found"
        exit /b 1
    )
    IF EXIST %VENV_PATH%\Scripts\deactivate.bat (
        call %VENV_PATH%\Scripts\deactivate.bat
    )
    rd /S /q %VENV_PATH%

    IF EXIST %VENV_PATH% (
        !ERR! "Removing environment %VENV_PATH% failed. Remove it manually"
        exit /b 1
    )
    exit /b 0

:collect
    pytest --collect-only tests
    exit /b 0

:cov
    set COV_INDEX=%SELF_DIR%build\htmlcov\index.html
    IF EXIST %COV_INDEX% (
        start firefox %COV_INDEX%
        @REM  ^^^ insert browser hare
    ) ELSE (
        !ERR! "Cannot find coverage file '%COV_INDEX%'"
    )
    exit /b 0

:test
    call :read_proj_cfg
    pytest tests -v --cov=%PROJ_SRC% --cov-report=term --cov-report=html:build/htmlcov --cov-report=xml --cov-fail-under=80
    exit /b 0

:clean
    set CACHE_DIRS=.mypy_cache .pytest_cache .ruff_cache build
    set CACHE_FILES=.cache

    !INFO! "Removing cache dirs"
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
    call :read_proj_cfg
    if not DEFINED REPO_NAME (
        !ERR! "Missing env variable 'REPO_NAME'"
        exit /b 1
    )
    start firefox "https://github.com/stanislavsabev/%REPO_NAME%"
    @REM  ^^^ insert browser hare
    exit /b 0

:setup
    set SRC_PATH=
    IF "%CMD_ARGV%" == "" (
        SET SRC_PATH=..
    ) ELSE (
        SET SRC_PATH="%CMD_ARGV%"
    )
    !DEBUG! "SRC_PATH: !SRC_PATH!"

    IF NOT EXIST %SRC_PATH%\ (
        !ERR! "Cannot find setup source '!SRC_PATH!'"
        exit /b 1
    )

    FOR %%F IN (%PROJ_CFG%; .python-cfg) DO (
        IF EXIST "%SRC_PATH%\%%F" (
            call fcopy /Y "%SRC_PATH%\%%F" "%%F"
        ) ELSE (
            !WARN! "Skipped missing file %SRC_PATH%\%%F"
        )
    )

    FOR %%D IN (.vscode; testing) DO (
        IF EXIST "%SRC_PATH%\%%D\" (
            dircopy /Y "%SRC_PATH%\%%D" "%%D\"
        ) ELSE (
            !WARN! "Skipped missing DIR %SRC_PATH%\%%D"
        )
    )
    exit /b 0

:proj-cfg
    call :env
    IF EXIST "%CD%\%PROJ_CFG%" (
        !ERR! "File '%PROJ_CFG%' exists"
        exit /b 1
    )
    call touch %PROJ_CFG%
    echo REPO_NAME=gh-repo-name>> %PROJ_CFG%
    echo PROJ_LANG=python>> %PROJ_CFG%
    echo PROJ_TYPE=restapi / package / batch / lib>> %PROJ_CFG%
    echo VENV_PATH=.venv>> %PROJ_CFG%
    !INFO! "File %PROJ_CFG% created"
    exit /b 0

:env
    !INFO! Env variables to be defined in [92m%PROJ_CFG%[0m
    echo.
    echo.[93mREPO_NAME[0m=gh-repo-name
    echo.[93mPROJ_LANG[0m=python
    echo.[93mPROJ_TYPE[0m=restapi / package / batch / lib
    echo.[93mVENV_PATH[0m=.venv[90m# if PROJ_LANG=python[0m
    exit /b 0

:define_commands
    !DEBUG! " ENTER :define_commands"

(set LF=^
%=EMPTY=%
)

    @rem ws=6
    SET ws=
    SET CMDS=^
format:!ws!Code formatting;^
check:!ws!Code style checks;^
checkall:!ws!Code formatting and style checks;^
build:!ws!Check all and run tests;^
req-update: [94m[-u][0m Compile and install requirements;^
req-install:!ws!Install requirements;^
req-compile: [94m[-u][0m Compile requirements;^
create-venv:!ws!Create venv;^
delete-venv:!ws!Delete venv;^
collect:!ws!Run pytest --collect-only;^
cov:!ws!Open coverage report;^
test:!ws!Run pytest with coverage;^
clean:!ws!Clear cache files and dirs;^
gh:!ws!Open project in GitHub;^
setup:[94m[SRC][0m Copy proj setup from parent ^dir or SRC path;^
env:!ws!variables to be defined in .proj-cfg;^
proj-cfg:!ws!Write to .proj-cfg;

    SET CMDV=
    SET DOCV=
    SET /A N_CMD=0

    FOR /F "tokens=1,* delims=:" %%a IN ("%CMDS:;=!LF!%") DO (
        SET /A N_CMD+=1
        SET CMDV[!N_CMD!]=%%a
        SET DOCV[!N_CMD!]=%%b
    )

    !DEBUG! "  EXIT :define_commands"
    exit /b 0
