@echo off
setlocal enabledelayedexpansion
set SELF=%~n0

if [%1] == [-h] goto :usage
if [%1] == [--help] goto :usage

set argCount=0
for %%x in (%*) do (
    set /A argCount+=1
    set "argVec[!argCount!]=%%~x"
)

for /L %%i in (1,1,%argCount%) do (
    echo Closing %%i- "!argVec[%%i!"
    taskkill /im "!argVec[%%i]!*" /f
)
goto :EOF
:usage
    echo usage: %SELF% [-h]
    echo  Taskkill multiple processes
    echo.
    echo    -h --help       Print this message
