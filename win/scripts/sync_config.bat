@echo off
SETLOCAL enableDelayedExpansion

set REV=
set COMND=xcopy

:GETOPTS
    set curOpt=%1
    set  curOpt1stChar=!curOpt:~0,1!

    rem The argument starts with a /.
    if [!curOpt1stChar!] == [/] (

        if /i [!curOpt!] == [/r] (
            set REV="r"
            shift
        ) else if /i [!curOpt!] == [/D] (
            set COMND=echo dry-run: !COMND!
            shift
        ) else if /i [!curOpt!] == [/?] (
            GOTO:Usage
        ) else (
            echo Unexpected option or flag !curOpt!
            GOTO:Usage
        )
        goto :GETOPTS
    )

if [%1] == [] (
    echo Missing config name/s
    exit /b
)

set DEST=
set SRC=
set PROC_NAME=

:NEXTNANE

    set NAME=%1
    if /I [!NAME!] == [code] (
        shift
        set DEST=%DOTFILES_DIR%\win\code
        set SRC=%AppData%\Code\User
        set PROC_NAME=proc_code
        GOTO:PROC
    ) else if /I [!NAME!] == [code-insiders] (
        shift
        set DEST=%DOTFILES_DIR%\win\code
        set SRC=%AppData%\Code\User
        set PROC_NAME=proc_code
        GOTO:PROC
    ) else if /I [!NAME!] == [git] (
        shift
        set DEST=%DOTFILES_DIR%\git
        set SRC=%USERPROFILE%
        set PROC_NAME=proc_git
        GOTO:PROC
    ) else if [!NAME!] == [] (
    exit /b
    ) else (
        echo Unknown config name "%1"
    )

:Usage
    echo usage: sync_config [/?] [/r/d] CONFIG_NAMES..
    echo    Sync config files between their location (SRC) and dotfiles repo (DEST)
    echo.
    echo    CONFIG_NAMES    NAME_1 ..NAME_N, config names 
    echo                    Valid names are: 
    echo                        code
    echo                        code-insiders
    echo                        git
    echo.
    echo    /r              reverse copy - from DEST to SRC
    echo    /D              dry-run, print commands that would be executed
    echo    /?              help, displays this message

GOTO:EOF

:PROC
    if DEFINED REV (
        set TMP_VAR=%DEST%
        set DEST=%SRC%
        set SRC=!TMP_VAR!
     )
     GOTO:!PROC_NAME!

:proc_code
    echo %PROC_NAME%
    
    @REM echo F|%COMND% /y %SRC%\settings.json %DEST%\settings.json
    echo F|%COMND% /y %SRC%\keybindings.json %DEST%\keybindings.json 
    @REM echo D|%COMND% /s/y "%SRC%\snippets\*" "%DEST%\snippets\*"
    GOTO:NEXTNANE

:proc_git
    echo %PROC_NAME%
    @REM echo F|%COMND% /y %SRC%\.gitconfig %DEST%\.gitconfig
    echo F|%COMND% /y %SRC%\.gitignore_global %DEST%\.gitignore_global
    GOTO:NEXTNANE

:End