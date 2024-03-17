@echo off
set SELF=%~n0

if [%1] == [-h] goto :usage
if [%1] == [--help] goto :usage

set VA=
SET PYTHON_CFG=.python-cfg
SET PROJ_CFG=.proj-cfg

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
    echo    VENV_PATH       If path is not set, the script is looking for '.python-cfg' file
    echo                    in current directory and reads VENV_PATH from first line.
    echo                    Finally, falls back to the default path '%VENV_NAME%'
    echo    -h --help       Print this message
