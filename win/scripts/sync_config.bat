@echo off
SETLOCAL enableDelayedExpansion

set XS=%DEVSETUP_DIR%\vscode
set XD=%AppData%\Code\User

if "%1"=="/r" ( 
    set XS=%AppData%\Code\User
    set XD=%DEVSETUP_DIR%\vscode
    shift
 )

set flag=%1
set SRC=!XS!
set DEST=!XD!

if "%flag%"=="/?" ( GOTO:Syntax )
if "%flag%"=="sett" ( GOTO:proc_sett )
if "%flag%"=="kb" ( GOTO:proc_kb )
if "%flag%"=="ext" ( GOTO:proc_ext )
if "%flag%"=="snip" ( GOTO:proc_snip )

:Syntax
    echo Usage:
    echo    %~n0 [/r] ^<option^> [^<sub_option^>] [^<xcopy_flags^>]
    echo.
    echo    Copies files from this repo to VSCode install dir, based on
    echo    the option value
    echo.
    echo    FLAGS:
    echo.
    echo      /r    Reverse copy. From VSCode install dir to this repo. 
    echo.
    echo    OPTIONS:
    echo.
    echo      What to copy
    echo.
    echo      sett  Copy 'settings.json'
    echo      kb    Copy 'keybindings.json'
    echo      ext   Copy extentions from 'G:' to %%AppData%% (slow^)
    echo      snip [sub_option ^<py/vba/my^>] ...
    echo            Copy snippets. ^If no sub option is provided, all snippets are copied
    echo    xcopy_flags ...
    echo            Additional flags to pass to 'xcopy'. See xcopy /?
    
GOTO:EOF

:proc_sett
    xcopy %2/y %SRC%\settings.json %DEST%\settings.json
    GOTO:EOF

:proc_kb
    xcopy %2/y %SRC%\keybindings.json %DEST%\keybindings.json
    GOTO:EOF

:proc_ext
    set /P sure=This might take a long time, are you sure (y/n)?

    if /I "%sure%" NEQ "y" (
        echo Operation cancelled...
    ) else (
        echo Copying...
        xcopy %2/s/y/j %SRC%\extensions %USERPROFILE%\.vscode\extensions
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
    xcopy "%SRC%\snippets\%op%*" "%DEST%\snippets\%op%*" %2/s/y
    GOTO:EOF

:End