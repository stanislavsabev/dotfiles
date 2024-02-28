@echo off
set SELF=%~n0

if [%1] == [-h] goto :usage
if [%1] == [--help] goto :usage
if [%1] == [] goto :invalid_args

SET _FNAME=%1

FOR /f "tokens=1,2 delims==" %%a in (%_FNAME%) DO (
    echo.SET %%a=%%b
    set %%a=%%b
)

goto:EOF

:invalid_args
    echo %SELF%: Missing file name argument, see -h for usage
    exit /b 1

:usage
    echo usage: %SELF% [-h] ENV_FILE
    echo.  Set env variables from file
    echo.
    echo    -h --help       Print this message
    echo    ENV_FILE        Env file name
