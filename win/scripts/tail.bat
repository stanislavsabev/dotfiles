@echo off
SETLOCAL enableDelayedExpansion
set SELF=%~n0

if [%1] == [-h] goto :usage
if [%1] == [--help] goto :usage
if [%1] == [] goto :usage
if [%2] == [] goto :usage


SET /a counter=0
set FILE_NAME=%2
set _CMD=call reverse %FILE_NAME%


FOR /F "tokens=* USEBACKQ" %%a IN (`%_CMD%`) DO (
    if "!counter!"=="%1" goto :EOF
    echo(%%a
    set /a counter+=1
)

goto :EOF
:usage
    echo usage: %SELF% [-h] N FILE
    echo.  Show last N non-blank lines in FILE
    echo.
    echo     -h -- help     Print this message
    echo     N              Number of lines to show
    echo     FILE_NAME      File to read from

