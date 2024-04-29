@echo off
SETLOCAL enableDelayedExpansion
set SELF=%~n0
SET SELF_DIR=%~dp0
SET PYSCRIPT_DIR=%SELF_DIR%..\..\pyscripts
SET PYTHON_EXE=%PYSCRIPT_DIR%\.venv\Scripts\python.exe

SET ARG=%~1
if not DEFINED ARG (
    SET ARG=%CD%
)

call %PYTHON_EXE% "%PYSCRIPT_DIR%\bump_toml_deps.py" %ARG%
