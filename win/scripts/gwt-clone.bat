@echo off
SETLOCAL enableDelayedExpansion
set SELF=%~n0

SET ARGC=0

SET DRY=
SET REMOTE=
SET LOCAL_DIR=

if [%1] == [] (
   goto:invalid_args
)

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
            goto :invalid_opt
        )
        shift
        goto :GETOPTS
    )

    @rem Positional arguments
    if not [!curOpt!] == [] (
        set /A ARGC+=1
        if !ARGC! EQU 1 (
            IF DEFINED REMOTE goto:invalid_args
            set REMOTE="!curOpt!"
        ) else if !ARGC! EQU 2 (
            IF DEFINED LOCAL_DIR goto:invalid_args
            set LOCAL_DIR="!curOpt!"
        ) else (
            goto :invalid_argc
        )
        shift
        goto :GETOPTS
    )
:ENDGETOPTS

IF not DEFINED REMOTE goto:invalid_args
IF not DEFINED LOCAL_DIR goto:invalid_args

if exist %LOCAL_DIR% (
    dir /A /B %LOCAL_DIR% | findstr /R ".">NUL && goto :repo_exists
) else (
    @rem Mkdir command
    set _CMD=Mkdir
    call :dry
    !_CMD! %LOCAL_DIR%
)

@rem Clone command
@rem syntax: git clone --bare remote-url .bare
set _CMD=cd
call :dry
!_CMD! %LOCAL_DIR%

set _CMD=git clone --bare
call :dry
!_CMD! %REMOTE% .bare

if not defined DRY (
    @rem Create gitfile
    echo gitdir: ./.bare> .git

    @rem Update git config
    git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
) else (
    echo dry-run: gitdir ./.bare^> .git
    echo dry-run: git config remote.origitn.fetch "+refs/heads/*:refs/remotes/origin/*"
)

set _CMD=git fetch --all
call :dry
!_CMD!

goto:EOF

@rem Prepend command with echo if DRY is defined
:dry
    IF DEFINED DRY (
        set _CMD=echo dry-run: !_CMD!
    )
    exit /b 0

:invalid_args
    echo %SELF%: Invalid arguments %ARGC%, see -h for usage
    exit /b 1

:invalid_opt
    echo %SELF%: Invalid flag !curOpt!, see -h for usage

:repo_exists
    echo %SELF%: Folder %LOCAL_DIR% already exists and is not empty

:usage
    echo usage: %SELF% [-h] [-n] REMOTE_URL LOCAL_DIR
    echo  Clone remote and setup local bare repository
    echo.
    echo    REMOTE_URL      Remote url
    echo    LOCAL_DIR       Destination folder to clone into
    echo.
    echo    -h --help       Print this message
    echo    -n --dry-run    Print the command that would run
