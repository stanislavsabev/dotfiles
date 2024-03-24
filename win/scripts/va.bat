@echo off
set SELF=%~n0

if [%1] == [-h] goto :usage
if [%1] == [--help] goto :usage

set VA=
SET PROJ_CFG=.proj-cfg
SET PYTHON_CFG=.python-cfg

if not [%1] == [] (
    set VA="%1"
) else if exist %PROJ_CFG% (
    call :read_proj_cfg
) else if exist %PYTHON_CFG% (
    call :read_python_cfg
)

if not DEFINED VA (
    set VA=%VENV_NAME%
)

%VA%\Scripts\activate.bat

goto :EOF

:read_python_cfg
    for /F "tokens=* USEBACKQ" %%F IN ( `head 1 %PYTHON_CFG%` ) do (
        SET VA=%%F
        exit /b 0
    )
    exit /b 1

:read_proj_cfg
    for /F "tokens=1,2 delims==" %%a IN ( %PROJ_CFG% ) do (
        if ["%%a"] == ["VENV_PATH"] (
            SET VA=%%b
            exit /b 0
        )
    )
    exit /b 1

:usage
    echo usage: %SELF% [-h] [VENV_PATH]
    echo  Activate Python virtual environment
    echo.
    echo    VENV_PATH       If not set, the script is looking in current directory for:
    echo.                   - variable 'VENV_PATH' defined in '.proj-cfg' file
    echo.                   - first line in '.python-cfg' file
    echo.                   - finally, falls back to the env variable '%VENV_NAME%'
    echo    -h --help       Print this message
