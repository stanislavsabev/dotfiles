@echo off
SETLOCAL enableDelayedExpansion
set SELF=%~n0

set REV=
set DRY=
set COMND=xcopy

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
set NAME=%1
shift

call :read_cmd_args

set SRC=
set DEST=
set DEST2=

set PROC_NAME=

if /I [!NAME!] == [code] (
    IF not defined CODE_USER_DIR (
        set CODE_USER_DIR=%AppData%\Code\User
    )
    set SRC=%CODE_USER_DIR%
    set DEST=%DOTFILES_DIR%\code
    set PROC_NAME=proc_code
) else if /I [!NAME!] == [code-insiders] (
    IF not defined CODE_USER_DIR (
        set CODE_USER_DIR="%AppData%\Code - Insiders\User"
    )
    set SRC=%CODE_USER_DIR%
    set DEST=%DOTFILES_DIR%\code\code-insiders
    set PROC_NAME=proc_code_insiders
) else if /I [!NAME!] == [git] (
    set SRC=%USERPROFILE%
    set DEST=%DOTFILES_DIR%\git
    set PROC_NAME=proc_git
) else (
    echo Unknown config name "!NAME!"
    exit /b 1
)

if DEFINED REV (
    set TMP_VAR=%DEST%
    set DEST=%SRC%
    set SRC=!TMP_VAR!
)

GOTO:!PROC_NAME!
GOTO:EOF

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
    exit /b 0


:proc_code_insiders
    set SNIP_SRC="%CODE_USER_DIR%\Code - Insiders"
    set SNIP_DEST=%DOTFILES_DIR%\code
    if DEFINED REV (
        set TMP_VAR=%SNIP_DEST%
        set SNIP_DEST=%SNIP_SRC%
        set SNIP_SRC=!TMP_VAR!
    )
    if defined DRY (
        echo dry-run: "echo F|%COMND% /Y %SRC%\settings.json %DEST%\settings.json"
        echo dry-run: "echo F|%COMND% /Y %SRC%\keybindings.json %DEST%\keybindings.json "
        echo dry-run: "echo D|%COMND% /I /Y /E "%SNIP_SRC%\snippets\*" "%SNIP_DEST%\snippets\*""
    ) else (
        echo F|%COMND% /Y %SRC%\settings.json %DEST%\settings.json
        echo F|%COMND% /Y %SRC%\keybindings.json %DEST%\keybindings.json 
        echo D|%COMND% /I /Y /E "%SNIP_SRC%\snippets\*" "%SNIP_DEST%\snippets\*"
    )
    exit /b 0

:proc_git
    if defined DRY (
        echo dry-run: "echo F|%COMND% /y %SRC%\.gitconfig %DEST%\.gitconfig"
        echo dry-run: "echo F|%COMND% /y %SRC%\.gitignore_global %DEST%\.gitignore_global"
    ) else (
        echo F|%COMND% /y %SRC%\.gitconfig %DEST%\.gitconfig
        echo F|%COMND% /y %SRC%\.gitignore_global %DEST%\.gitignore_global
    )
    exit /b 0

:read_cmd_args
    set /A CMD_ARGC=0
    set CMD_ARV=

:getcmdopts
    if [%1] == [] (
        exit /b 0
    )
    set /A CMD_ARGC+=1
    set CMD_ARV[!CMD_ARGC!]=%1
    shift
    goto :getcmdopts
exit /b 0


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