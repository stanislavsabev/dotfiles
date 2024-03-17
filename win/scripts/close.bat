@echo off
setlocal enabledelayedexpansion
set SELF=%~n0

if [%1] == [-h] goto :usage
if [%1] == [--help] goto :usage
if [%1] == [] (
    echo %SELF%: Missing argument for task, see -h for usage
    goto :EOF
)

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
    echo usage: %SELF% [-h] TASK_LIST..
    echo  Taskkill multiple processes
    echo.
    echo    -h --help       Print this message
    echo    TASK_LIST       Patterns of tasks to kill