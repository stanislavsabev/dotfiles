@echo off
set SELF=%~n0

if [%1] == [-h] goto :usage
if [%1] == [--help] goto :usage
if [%1] == [] goto :usage
if [%2] == [] goto :usage

call :print_head %1 %2
goto :EOF

@rem Show first N non-blank lines in FILE
:print_head
    setlocal enabledelayedexpansion
    set /a counter=0

    for /f ^"usebackq^ eol^=^

^ delims^=^" %%a in (%2) do (
    if "!counter!"=="%1" goto :EOF
    echo %%a
    set /a counter+=1
)
    exit /b 0

:usage
    echo usage: %SELF% [-h] N FILE
    echo  Show first N non-blank lines in FILE
    echo.
    echo    -h --help       Print this message
