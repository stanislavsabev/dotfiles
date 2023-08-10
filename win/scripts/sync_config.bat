@echo off
SETLOCAL enableDelayedExpansion

set REV=
set COMND=xcopy

:GETOPTS
    set curArg=%1
    set  curArg1stChar=!curArg:~0,1!

    rem The argument starts with a /.
    if [!curArg1stChar!] == [/] (

        if /i [!curArg!] == [/r] (
            set REV="1"
            shift
        ) else if /i [!curArg!] == [/D] (
            set COMND=echo dry-run: !COMND!
            shift
        ) else if /i [!curArg!] == [/?] (
            GOTO:Usage
        ) else (
            echo Unexpected option or flag !curArg!
            exit /b
        )
        goto :GETOPTS
    )

if [%1] == [] (

  echo Config name/s expected
  exit /b

)

echo "rev:" %REV% 
echo "cmd:" %COMND% 
echo "%1"
exit 0

@REM set DEST=%DOTFILES_DIR%\win\code
@REM set SRC=%AppData%\Code\User
@REM if "%1"=="/r" (
@REM     set TMP_VAR=%DEST%
@REM     set DEST=%SRC%
@REM     set SRC=!TMP_VAR!
@REM     shift
@REM  )


@REM set option=%1

@REM if "%option%"=="/?" ( GOTO:Usage )
@REM if "%option%"=="sett" ( GOTO:proc_sett )
@REM if "%option%"=="kb" ( GOTO:proc_kb )
@REM @REM if "%option%"=="ext" ( GOTO:proc_ext )
@REM if "%option%"=="snip" ( GOTO:proc_snip )

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