@echo off

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
    echo Usage:
    echo    %~n0 [-a/-d/-f]
    echo.
    echo    FLAGS:
    echo      -a  This is the default. Lists files and directories
    echo          starting with `.`.
    echo      -d  Lists directories starting with `.`.
    echo      -f  Lists files starting with `.`.
    echo.
    GOTO:EOF

:End
