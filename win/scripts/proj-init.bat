@echo off
SETLOCAL enableDelayedExpansion
set SELF=%~n0

(set LF=^
%=EMPTY=%
)

set USER=stanislavsabev
set EMAIL=bezraboten.34@gmail.com
set DRY=

@REM Variables to be defined in .proj-cfg
::    PROJ_NAME
::    PROJ_LANG
::    PROJ_TYPE=restapi | package | batch | lambda | lib
::
:: IF PROJ_LANG=python
::    VENV_PATH
::
:: IF PROJ_TYPE=lambda
::    LAMBDA_NAME
set PROJ_CFG=.proj-cfg
set PROJ_NAME=
set PROJ_LANG=tbd
set PROJ_TYPE=tbd

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
        ) else if [!curOpt!] == [-e] (
            if not [%2] == [] (
                set EMAIL=%~2
                shift
            ) else (
                call :invalid_opt
           )
        ) else if [!curOpt!] == [--email] (
            if not [%2] == [] (
                set EMAIL=%~2
                shift
            ) else (
                call :invalid_opt
           )
        ) else if [!curOpt!] == [-u] (
            if not [%2] == [] (
                set USER=%~2
                shift
            ) else (
                call :invalid_opt
           )
        ) else if [!curOpt!] == [--user] (
            if not [%2] == [] (
                set USER=%~2
                shift
            ) else (
                call :invalid_opt
           )
        ) else if [!curOpt!] == [-l] (
            if not [%2] == [] (
                set PROJ_LANG=%~2
                shift
            ) else (
                call :invalid_opt
           )
        ) else if [!curOpt!] == [--lang] (
            if not [%2] == [] (
                set PROJ_LANG=%~2
                shift
            ) else (
                call :invalid_opt
           )
        ) else if [!curOpt!] == [-n] (
            if not [%2] == [] (
                set PROJ_LANG=%~2
                shift
            ) else (
                call :invalid_opt
           )
        ) else if [!curOpt!] == [--name] (
            if not [%2] == [] (
                set PROJ_NAME=%~2
                shift
            ) else (
                call :invalid_opt
           )
        ) else (
            goto :invalid_opt
        )
        shift
        goto :GETOPTS
    )
:ENDGETOPTS

if not defined PROJ_NAME (
    call :get_proj_name
)

set CMDS=^
git init;^
git config --local user.name !USER!;^
git config --local user.email !EMAIL!;

FOR /F "delims=" %%a in ("%CMDS:;=!LF!%") do (
    if DEFINED DRY (
        echo.%%a
    ) else (
        call %%a
    )
)

if not DEFINED DRY (
    echo !PROJ_CFG! > ".gitignore"

    (
        echo PROJ_NAME=!PROJ_NAME!
        echo PROJ_LANG=!PROJ_LANG!
        echo PROJ_TYPE=!PROJ_TYPE!
    ) > "!PROJ_CFG!"
) else (
    echo.echo !PROJ_CFG! ^> .gitignore
    echo.echo PROJ_NAME=!PROJ_NAME! ^>^> "!PROJ_CFG!"
    echo.echo PROJ_LANG=!PROJ_LANG! ^>^> "!PROJ_CFG!"
    echo.echo PROJ_TYPE=!PROJ_TYPE! ^>^> "!PROJ_CFG!"
)

goto :EOF

:get_proj_name
    set MYDIR=%CD%
    for %%f in ("%MYDIR%") do set "myfolder=%%~nxf"
    echo PROJ_NAME=%myfolder%
    set PROJ_NAME=%myfolder%
    exit /b 0

:invalid_opt
    echo %SELF%: No value specified for '!curOpt!'
    exit /b 1

:usage
    echo usage: %SELF% [-h] [-u USER] [-e EMAIL] [-l PROJ_LANG] [-t PROJ_TYPE]
    echo  Initiates project in current directory
    echo    Creates git repository with user name, email and '.gitignore' file
    echo    Adds '!PROJ_CFG!' env file with variables
    echo.
    echo    -h --help       Print this message
    echo    -n --dry-run    Dry run
    echo.
    echo    -u --user       Git user.name
    echo    -e --email      Git user.email
    echo    -n --name       If empty, project name is taken to be current directory name
    echo    -l --lang       python ^| rust ^| c ^| cpp ^| vba etc.
    echo    -t --type       batch ^| package ^| restapi ^| lambda ^| lib etc.