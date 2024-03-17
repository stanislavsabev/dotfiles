@echo off
SETLOCAL enableDelayedExpansion
set SELF=%~n0

SET L=0
SET A=0
SET F=0
SET D=0
SET DOT=0
SET POS_ARGS=

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
        ) else if [!curOpt!] == [-l] (
            SET L=1
        ) else if [!curOpt!] == [-a] (
            set A=1
        ) else if [!curOpt!] == [-la] (
            set A=1
            set L=1
        ) else if [!curOpt!] == [-al] (
            set A=1
            set L=1
        ) else if [!curOpt!] == [--dot] (
            SET DOT=1
        ) else if [!curOpt!] == [-D] (
            SET D=1
        ) else if [!curOpt!] == [-F] (
            SET F=1
        ) else (
            echo %SELF%: Invalid flag !curOpt!, see -h for usage
            goto :EOF
        )
    ) ELSE (
        if not DEFINED POS_ARGS (
            set POS_ARGS= %1
        ) else (
            echo %SELF%: Invalid number of positional arguments, see -h for usage
            goto :EOF
        )
    )
    shift
    goto :GETOPTS
:ENDGETOPTS

SET ALL= /A
IF "!D!"=="1" (
    SET ALL=!ALL!D
) ELSE IF "!F!"=="1" (
    SET ALL=!ALL!-D
)

SET BARE=
SET FSTR_OPTS=
IF ["!L!"] == ["0"] (
    SET BARE= /B
    set FSTR_OPTS=/B "\."
) else if ["!L!"] == ["1"] (
    set FSTR_OPTS=/E "\<\..*"
)
IF ["!DOT!"] == ["0"]  set FSTR_OPTS=/V !FSTR_OPTS!
IF ["!A!"] == ["1"] set FSTR_OPTS=

@REM echo. A: !A! L: !L! DOT: !DOT!
@REM echo.FSTR_OPTS: !FSTR_OPTS! ALL: !ALL! BARE: !BARE!
@REM echo.POS_ARGS: !POS_ARGS!

SET _CMD=dir!BARE!!ALL!

if DEFINED FSTR_OPTS (
    call !_CMD!!POS_ARGS! | FINDSTR !FSTR_OPTS!
) else (
    call !_CMD!!POS_ARGS!
)
GOTO:EOF

:usage
    echo usage: %SELF% [-h] [-la] [--dot] [-D ^| -F] [PATH]
    echo  List files and directories
    echo.
    echo    -h --help  Print this message
    echo.
    echo      -l       Formatted list view
    echo      -a       List all, including .files and .dirs
    echo   --dot       List only .files and .dirs
    echo      -D       Directories only
    echo      -F       Files only
    echo    PATH       Directory and/or files to list
