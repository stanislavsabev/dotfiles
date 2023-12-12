@echo off
setlocal enableDelayedExpansion

if "%1"=="-h" ( GOTO:usage )
if "%1"=="--help" ( GOTO:usage )
if "%1"=="-f" ( GOTO:rm_f )
if "%1"=="-r" ( GOTO:rm_r )
if "%1"=="-rf" ( GOTO:rm_rf )
if not "%1"=="" ( GOTO:rm )

:usage
    echo Usage:
    echo    %~n0 [-r[f]] FILENAME ^| DIRNAME
    echo.
    GOTO:EOF

:rm_f
    shift
    DEL /f %1
    GOTO:EOF

:rm_r
    shift
    for %%i in (%1) do if exist %%~si\NUL (
        rd /S %1
    ) else (
        del %1
    )
    GOTO:EOF

:rm_rf
    shift
    for %%i in (%1) do if exist %%~si\NUL (
        rd /S /Q %1
    ) else (
        del /F %1
    )
    GOTO:EOF

:rm
    for %%i in (%1) do if exist %%~si\NUL (
        rd %1
    ) else (
        del %1
    )
    GOTO:EOF

:End
endlocal