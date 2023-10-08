@echo off
SETLOCAL enableDelayedExpansion
set SELF=%~n0

SET ARGC=0
SET PROJ=
SET BRANCH=
SET DRY=
SET LS=
SET CD_PROJ=

if [%1] == [] goto :invalid_argc

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
        ) else if [!curOpt!] == [-d] (
            set DRY=1
        ) else if [!curOpt!] == [--dry-run] (
            set DRY=1
        ) else if [!curOpt!] == [-cd] (
            set CD_PROJ=1
        ) else if [!curOpt!] == [-l] (
            set LS=l
        ) else if [!curOpt!] == [-lr] (
            set LS=r
        ) else if [!curOpt!] == [-la] (
            set LS=a
        ) else (
            echo %SELF%: Invalid flag !curOpt!, see -h for usage
            exit /b 1
        ) 

        shift
        goto :GETOPTS
    )
    @rem Positional arguments
    if not [!curOpt!] == [] (
        if !ARGC! EQU 0 (
            if [!curOpt!] == [dot] (
                set PROJ=%DOTFILES_DIR%
            ) else if exist %PROJECTS_DIR%\!curOpt!\ (
                set PROJ=%PROJECTS_DIR%\!curOpt!
            ) else (
                echo %SELF%: Unknown project name !curOpt!, see -h for help
                exit /b 1
            )
        ) else if !ARGC! EQU 1 (
            set BRANCH=!curOpt!
        ) else (
            goto :invalid_argc
        )
        set /A ARGC+=1
        shift
        goto :GETOPTS
    )

:ENDGETOPTS

if not DEFINED PROJ (
    @rem List all projects
    if "%LS%" EQU "-l" (
        dir /a %PROJECTS_DIR%
        goto :EOF
    )
    goto:missing_proj_arg
)

@rem ls-remote command
if DEFINED LS (
    set _CMD="pushd %PROJ% && GIT BRANCH !LS! %% popd"
    call :dry
    cmd /C !_CMD!
    goto :EOF
)

IF DEFINED CD_PROJ goto:proc_cd_proj
goto:proc_open_proj

:proc_cd_proj @rem Navigate to project
    set _CMD=pushd
    call :dry
    !_CMD! %PROJ%\%BRANCH%
    pushd .
    ENDLOCAL
    popd
    goto :EOF

:proc_open_proj @rem Open project with editor
    set _CMD=%EDITOR%
    call :dry
    !_CMD! %PROJ%\%BRANCH%
    goto :EOF

@rem Prepend command with echo if DRY is defined
:dry
    IF DEFINED DRY (
        set _CMD=echo dry-run: !_CMD!
    )
    exit /b 0

:invalid_argc
    echo %SELF%: Invalid number of arguments %ARGC%, see -h for usage
    exit /b 1

:missing_proj_arg
    echo %SELF%: Missing project name, see -h for usage
    exit /b 1

:usage
    echo usage: %SELF% [-h] [-d] [-l [-lr -la]] [-cd] PROJ [BRANCH]
    echo  Open project
    echo.
    echo    -h --help       Prints this message
    echo    -d --dry-run    Print the command that would run
    echo    -l -lr -la      List branches: local, remote, all
    echo                    If no PROJ is provided, list all projects
    echo    -cd             Navigate to project instead of opening it with editor
    echo.
    echo    PROJ            Full project name or short name. Supported short names:
    echo                    dot
    echo.
    echo    BRANCH          Branch name, optional
