@echo off
SETLOCAL enableDelayedExpansion

set DEST=%DOTFILES_DIR%\win\vscode
set SRC=%AppData%\Code\User
if "%1"=="/r" (
    set TMP_VAR=%DEST%
    set DEST=%SRC%
    set SRC=!TMP_VAR!
    shift
 )

set COMND=xcopy
if "%1"=="/D" (
    set COMND=echo dry-run: !COMND!
    shift
 )

set option=%1

if "%option%"=="/?" ( GOTO:Usage )
if "%option%"=="sett" ( GOTO:proc_sett )
if "%option%"=="kb" ( GOTO:proc_kb )
@REM if "%option%"=="ext" ( GOTO:proc_ext )
if "%option%"=="snip" ( GOTO:proc_snip )

:Usage
    echo Usage:
    echo    %~n0 [/r] [/D] ^<option^> [^<sub_option^>] [^<xcopy-flags^>] 
    echo.
    echo    Copies files from this repo to VSCode install dir, based on
    echo    the option value
    echo.
    echo      /r    Reverse copy. From VSCode install dir to this repo. 
    echo      /D    Dry-run. Print the command, that would be executed.
    echo.
    echo    option What to copy
    echo.
    echo      sett  Copy 'settings.json'
    echo      kb    Copy 'keybindings.json'
    echo      ext   Copy extentions from 'G:' to %%AppData%% (slow^)
    echo      snip [sub_option ^<py/vba/my^>] ...
    echo            Copy snippets. ^If no sub option is provided, all snippets are copied
    echo.
    echo    xcopy-flags Additional flags to pass to 'xcopy'. See xcopy /?
    
GOTO:EOF

:proc_sett
    echo F|%COMND% %2/y %SRC%\settings.json %DEST%\settings.json
    GOTO:EOF

:proc_kb
    echo F|%COMND% %SRC%\keybindings.json %DEST%\keybindings.json %2/y
    GOTO:EOF

:proc_ext
    set /P sure=This might take a long time, are you sure (y/n)?

    if /I "%sure%" NEQ "y" (
        echo Operation cancelled...
    ) else (
        echo Copying...
        %COMND% %SRC%\extensions %USERPROFILE%\.vscode\extensions %2/s/y/j
    )
    GOTO:EOF

:proc_snip
    set op=
    for %%G in ("py" "vba" "my") do (
        if /I "%~2"=="%%~G" (
            set "op=%~2"
            shift /2
            GOTO:match
        )
    )
    :match
    %COMND% "%SRC%\snippets\%op%*" "%DEST%\snippets\%op%*" %2/s/y
    GOTO:EOF

:End