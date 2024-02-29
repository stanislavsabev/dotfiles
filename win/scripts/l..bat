@echo off
set SELF=%~n0

if [%1] == [-h] goto :usage
if [%1] == [--help] goto :usage
if "%1"=="-a" ( GOTO:dir_dotall )
if "%1"=="-d" ( GOTO:dir_dotdirs )
if "%1"=="-f" ( GOTO:dir_dotfiles )
if not "%1"=="" ( GOTO:usage )

:dir_dotall
    dir .*.* /A
    GOTO:EOF

:dir_dotdirs
    dir .*.* /AD
    GOTO:EOF

:dir_dotfiles
    dir .*.* /A-D
    GOTO:EOF

:usage
    echo usage: %SELF% [-h] [-a] [-d] [-f]
    echo  List files and directory names starting with dot (.)
    echo.
    echo    -h --help  Print this message
    echo.
    echo    -a         Default. Lists files and directories
    echo    -d         Lists directories only
    echo    -f         Lists files only
    echo.
    GOTO:EOF
