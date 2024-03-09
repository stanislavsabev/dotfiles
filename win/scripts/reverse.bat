@echo off
setlocal
set SELF=%~n0

if [%1] == [-h] goto :usage
if [%1] == [--help] goto :usage
if [%1] == [] goto :usage


set "n=10000000"
for /F "usebackq tokens=1* delims=:" %%a in (`
   (echo off ^& for /F "delims=" %%c in ('findstr /N "^" "%~1"'^) do (
   set /A "n-=1" ^& echo %%n%% %%c^)^) ^| sort`) do echo(%%b