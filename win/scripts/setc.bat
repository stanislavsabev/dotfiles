@echo off
set SELF=%~n0
SETLOCAL enableDelayedExpansion
if [%1] == [/?] goto :usage
if [%1] == [-h] goto :usage @rem Undocumented on purpose
if [%1] == [] goto :invalid_args
if [%2] == [] goto :invalid_args


SET varname=%1
set _CMD=%2
set NL=^


@REM echo varname %varname%
@REM echo _CMD %_CMD%

SET result=
FOR /F "tokens=* USEBACKQ" %%F IN (`%_CMD%`) DO (
    SET result=%%F
)

if DEFINED result (
    endlocal & (
        set "%varname%=%result%"
    )
)
goto :EOF

:invalid_args
    echo %SELF%: Invalid number of arguments %ARGC%, see /? for usage
    exit /b 1

:usage
    echo usage: %SELF% [/?] VAR_NAME "COMMAND"
    echo.  Set variable to the last output line from a command
    echo.
    echo     /?             Print this message
    echo     VAR_NAME       Name of a global variable
    echo     "COMMAND"      Command to execute (surround with quotes)
    echo                    Note: Command must be surrounded with quotes
