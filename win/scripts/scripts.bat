@echo off
SETLOCAL enableDelayedExpansion
set SELF=%~n0
set SELF_DIR=%~dp0

set SELF_COLORED=[90m%SELF%[0m

set /A ARGC=0

SET DRY=
SET VERBOSE=
SET DEBUG=echo %date% %time:~0,8% ^| %SELF_COLORED% [36m[DEBUG][0m:
SET DEBUG=

if [%1] == [] (
   goto :ls
)
call :define_commands

:GETOPTS
    if [%1] == [] goto :ENDGETOPTS
    SET curOpt=%1
    SET curOpt1stChar=!curOpt:~0,1!

    @rem Flags
    if [!curOpt1stChar!] == [-] (
        if [!curOpt!] == [-h] (
            goto :usage
        ) else if [!curOpt!] == [--help] (
            goto :usage
        ) else if [!curOpt!] == [-n] (
            set DRY=1
        ) else if [!curOpt!] == [--dry-run] (
            set DRY=1
        ) else (
            echo %SELF%: Invalid option !curOpt!, see -h for usage
            goto :EOF
        )
        shift
        goto :GETOPTS
    ) else (
        @rem Match command
        call :match_command
        if DEFINED COMMAND goto :ENDGETOPTS

        echo %SELF%: Unknown command or script '!curOpt!', see -h for usage
        goto :EOF
    )
:ENDGETOPTS

IF not DEFINED COMMAND (
    echo %SELF%: Missing argument for COMMAND
    goto :EOF
)

set CMD_ARGS=
set /A CMD_ARGC=0
:PARSE_COMMAND_ARGS
    shift
    if "%1"=="" goto :END_PARSE_COMMAND_ARGS
    set /A CMD_ARGC+=1
    if DEFINED CMD_ARGS (
        set CMD_ARGS=!CMD_ARGS! %1
    ) else (
        set CMD_ARGS=%1
    )
    goto :PARSE_COMMAND_ARGS
:END_PARSE_COMMAND_ARGS

!DEBUG! COMMAND: !COMMAND!
!DEBUG! CMD_ARGS: !CMD_ARGS!
call :!COMMAND!
goto :EOF

:print_commands
    !DEBUG! " ENTER :print_commands"

    for /L %%i in (1,1,!N_CMDS!) do (
        set ALIGNED=              !CMDS[%%i]!
        echo !ALIGNED:~-12!       !DOCS[%%i]!
    )
    !DEBUG! " EXIT  :print_commands"
    exit /b 0

:match_command
    !DEBUG! " ENTER :match_command"

    for /L %%i in (1,1,!N_CMDS!) do (
        if "!curOpt!" == "!CMDS[%%i!" {
            set COMMAND=!curOpt!
            set DOC=!DOCS[%%i]!
            !DEBUG! " EXIT  :match_command"
            exit /b 0
        }
    )
    !DEBUG! " UNABLE TO MATCH :match_command"
    exit /b 1

:read_scripts
    !DEBUG! " ENTER :read_scripts"

    set /a N_SCRIPTS=0
    set SCRIPTS=
    set /a N_PRIV=0
    set PRIV_SCRIPTS=

    pushd %SELF_DIR%
    for %%f in ( *.bat ) do (
        set /a N_SCRIPTS+=1
        set SCRIPTS[!N_SCRIPTS!]=%%f
    )
    pushd %SELF_DIR%priv
    for %%f in ( *.bat ) do (
        set /a N_PRIV+=1
        set PRIV_SCRIPTS[!N_PRIV!]=%%f
    )
    popd

    !DEBUG! " EXIT  :read_scripts"
    exit /b 0

:print_scripts
    !DEBUG! " ENTER :print_scripts"

    for /L %%i in (1,1,!N_SCRIPTS!) do (
        echo ^> !SCRIPTS[%%i]:~0,-4!
        if DEFINED VERBOSE (
            call !SCRIPTS[%%i]! -h
        )
    )
    for /L %%i in (1,1,!N_PRIV!) do (
        echo ^> !PRIV_SCRIPTS[%%i]:~0,-4!
        if DEFINED VERBOSE (
            call !PRIV_SCRIPTS[%%i]! -h
        )
    )
    !DEBUG! " EXIT  :print_scripts"
    exit /b 0

:ls
    if ["!CMD_ARGS!"] == ["--verbose"] set VERBOSE=1
    call :read_scripts
    call :print_scripts
    exit /b 0

:find
    call :read_scripts
    dir /A /D %SELF_DIR% | findstr !CMD_ARGS!
    dir /A /D %SELF_DIR%\priv | findstr !CMD_ARGS!
    exit /b 0

:cat
    SET _NAME=!CMD_ARGS!

    call cat %SELF_DIR%%_NAME%.bat
    exit /b 0

:ed
    if !CMD_ARGC! EQU 0 (
        call %EDITOR% %SELF_DIR%
        exit /b 0
    )

    SET _NAME=!CMD_ARGS!
    call %EDITOR% %SELF_DIR%%_NAME%.bat
    exit /b 0

:define_commands
    !DEBUG! " ENTER :define_commands"

    set CMDS=
    set DOCS=
    SET /A N_CMDS=0

    SET /A N_CMDS+=1
    set CMDS[!N_CMDS!]=ls
    set DOCS[!N_CMDS!]=List scripts [--verbose]

    SET /A N_CMDS+=1
    set CMDS[!N_CMDS!]=find
    set DOCS[!N_CMDS!]=Find script by pattern

    SET /A N_CMDS+=1
    set CMDS[!N_CMDS!]=cat
    set DOCS[!N_CMDS!]=Cat script by name

    SET /A N_CMDS+=1
    set CMDS[!N_CMDS!]=ed
    set DOCS[!N_CMDS!]=Open script in default editor

    !DEBUG! " EXIT  :define_commands"
    exit /b 0

:usage
    echo usage: %SELF% [-h] [-n] COMMAND
    echo  Manage win scripts
    echo.
    echo    FLAGS
    echo    -h --help       Print this message
    echo    -n --dry-run    Print command that would run
    echo.
    echo    COMMANDS
    call :print_commands
    exit /b 0