@echo off
SETLOCAL enableDelayedExpansion
set SELF=%~n0
set SELF_DIR=%~dp0

set SELF_COLORED=[90m%SELF%[0m

SET /a ARGC=0

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

set /A ARGC=0
set COMMAND_ARGS=
:PARSE_COMMAND_ARGS
    shift
    if "%1"=="" goto :END_PARSE_COMMAND_ARGS
    set ARGC+=1
    if DEFINED COMMAND_ARGS (
        set COMMAND_ARGS=!COMMAND_ARGS! %1
    ) else (
        set COMMAND_ARGS=%1
    )
    goto :PARSE_COMMAND_ARGS
:END_PARSE_COMMAND_ARGS

!DEBUG! COMMAND: !COMMAND!
!DEBUG! COMMAND_ARGS: !COMMAND_ARGS!
call :!COMMAND!
goto :EOF

:print_commands
    !DEBUG! " ENTER :print_commands"

    for /L %%i in (1,1,!n_cmds!) do (
        set ALIGNED=              !CMDS[%%i]!
        echo !ALIGNED:~-12!       !DOCS[%%i]!
    )
    !DEBUG! " EXIT  :print_commands"
    exit /b 0

:match_command
    !DEBUG! " ENTER :match_command"

    for /L %%i in (1,1,!n_cmds!) do (
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

    set /a n_scripts=0
    set SCRIPTS=

    pushd %SELF_DIR%
    for %%f in ( *.bat ) do (
        set /a n_scripts+=1
        set SCRIPTS[!n_scripts!]=%%f
    )
    popd

    !DEBUG! " EXIT  :read_scripts"
    exit /b 0

:print_scripts
    !DEBUG! " ENTER :print_scripts"

    for /L %%i in (1,1,!n_scripts!) do (
        echo ^> !SCRIPTS[%%i]:~0,-4!
        if DEFINED VERBOSE (
            call !SCRIPTS[%%i]! -h
        )
    )
    !DEBUG! " EXIT  :print_scripts"
    exit /b 0

:ls
    if ["!COMMAND_ARGS!"] == ["--verbose"] set VERBOSE=1
    call :read_scripts
    call :print_scripts
    exit /b 0

:find
    call :read_scripts
    dir /A /D %SELF_DIR% |findstr !COMMAND_ARGS!
    exit /b 0

:cat
    SET _NAME=!COMMAND_ARGS!

    call cat %SELF_DIR%%_NAME%.bat
    exit /b 0

:ed
    if !ARGC! EQU 0 (
        echo TODO: [2024/03/02, 19:04:44] Start here
        goto :EOF
    )


    SET _NAME=!COMMAND_ARGS!
    echo. call %EDITOR% %SELF_DIR%%_NAME%.bat
    exit /b 0

:define_commands
    !DEBUG! " ENTER :define_commands"

    set CMDS=
    set DOCS=
    SET /A n_cmds=0

    SET /A n_cmds+=1
    set CMDS[!n_cmds!]=ls
    set DOCS[!n_cmds!]=List scripts [--verbose]

    SET /A n_cmds+=1
    set CMDS[!n_cmds!]=find
    set DOCS[!n_cmds!]=Find script by pattern

    SET /A n_cmds+=1
    set CMDS[!n_cmds!]=cat
    set DOCS[!n_cmds!]=Cat script by name

    SET /A n_cmds+=1
    set CMDS[!n_cmds!]=ed
    set DOCS[!n_cmds!]=Open script in default editor

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