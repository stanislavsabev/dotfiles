@echo off
set SELF=%~n0
if [%1] == [-h] goto :usage
if [%1] == [--help] goto :usage

call proj-init --lang rust %*

goto :EOF
:usage
  echo usage: %SELF% redirect to
  call proj-init -h
