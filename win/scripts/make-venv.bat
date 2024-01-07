@echo off
set SELF=%~n0

if [%1] == [-h] goto :usage
if [%1] == [--help] goto :usage

set VA=
SET PYTHON_CFG=.python-cfg

if not [%1] == [] (
    set VA="%1"
) else if exist %PYTHON_CFG% (
    call :read_python_cfg
)

if not DEFINED VA (
    set VA=%VENV_NAME%
)

python -m venv %VA%
call %VA%\Scripts\activate.bat

goto :EOF

:read_python_cfg
    for /F "tokens=* USEBACKQ" %%F IN ( 'head 1 %PYTHON_CFG%' ) do (
        SET VA=%%F
        exit /b 0
    )
    exit /b 1

:usage
    echo usage: %SELF% [-h] [VENV_PATH]
    echo  Create and activate python virtual environment
    echo.
    echo    VENV_PATH       If path is not set, the script is looking for '.python-cfg' file
    echo                    in current directory and reads VENV_PATH from first line.
    echo                    Finally, falls back to the default path '%VENV_NAME%'
    echo    -h --help       Print this message
