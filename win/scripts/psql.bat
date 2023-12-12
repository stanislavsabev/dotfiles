@echo off
set SELF=%~n0

if [%1] == [-h] goto :usage
if [%1] == [--help] goto :usage

call "C:\Program Files\PostgreSQL\15\scripts\runpsql.bat"

goto :EOF
:usage
    echo usage: %SELF% [-h]
    echo  Run PostgreSQL
    echo.
    echo    -h --help       Print this message
