@echo off
SETLOCAL enableDelayedExpansion
set SELF=%~n0

set REV=
set DRY=
set COMND=xcopy
IF not defined CODE_USER_DIR (
    set CODE_USER_DIR=%AppData%\Code\User
)

:GETOPTS
    set curOpt=%1
    set  curOpt1stChar=!curOpt:~0,1!

    rem The argument starts with a /.
    if [!curOpt1stChar!] == [-] (
        if /i [!curOpt!] == [-h] (
            GOTO:Usage
        ) else if /i [!curOpt!] == [--help] (
            GOTO:Usage
        ) else if /i [!curOpt!] == [-r] (
            set REV=1
        ) else if /i [!curOpt!] == [--reverse] (
            set REV=1
        ) else if /i [!curOpt!] == [-n] (
            SET DRY=1
        ) else if /i [!curOpt!] == [--dry-run] (
            SET DRY=1
        ) else (
            echo Unexpected option or flag !curOpt!, see -h for help
        )
        shift
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
        set SRC=%CODE_USER_DIR%
        set PROC_NAME=proc_code
        GOTO:PROC
    ) else if /I [!NAME!] == [code-insiders] (
        shift
        set DEST=%DOTFILES_DIR%\win\code-insiders
        set SRC=%CODE_USER_DIR%
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
        goto :EOF
    )
    exit /b 0

GOTO:EOF

:PROC
    if DEFINED REV (
        set TMP_VAR=%DEST%
        set DEST=%SRC%
        set SRC=!TMP_VAR!
     )
     GOTO:!PROC_NAME!

:proc_code
    if defined DRY (
        echo dry-run: "echo F|%COMND% /Y %SRC%\settings.json %DEST%\settings.json"
        echo dry-run: "echo F|%COMND% /Y %SRC%\keybindings.json %DEST%\keybindings.json "
        echo dry-run: "echo D|%COMND% /I /Y /E "%SRC%\snippets\*" "%DEST%\snippets\*""
    ) else (
        echo F|%COMND% /Y %SRC%\settings.json %DEST%\settings.json
        echo F|%COMND% /Y %SRC%\keybindings.json %DEST%\keybindings.json 
        echo D|%COMND% /I /Y /E "%SRC%\snippets\*" "%DEST%\snippets\*"
    )
    GOTO:NEXTNANE

:proc_git
    if defined DRY (
        echo dry-run: "echo F|%COMND% /y %SRC%\.gitconfig %DEST%\.gitconfig"
        echo dry-run: "echo F|%COMND% /y %SRC%\.gitignore_global %DEST%\.gitignore_global"
    ) else (
        echo F|%COMND% /y %SRC%\.gitconfig %DEST%\.gitconfig
        echo F|%COMND% /y %SRC%\.gitignore_global %DEST%\.gitignore_global
    )
    GOTO:NEXTNANE

:Usage
    echo usage: sync-config [-h] [-r] [-n] CONFIG_NAMES..
    echo    Sync config files between their location (SRC) and dotfiles repo (DEST)
    echo.
    echo    CONFIG_NAMES    Config names: NAME_1 ..NAME_N, 
    echo            code
    echo   code-insiders
    echo             git
    echo.
    echo    -h    --help    Display this message
    echo    -r --reverse    Reverse copy, DEST to SRC
    echo    -n --dry-run    Print commands that would be executed