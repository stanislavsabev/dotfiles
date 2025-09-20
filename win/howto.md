# **HOWTO**

Clone [dotfiles](https://github.com/stanislavsabev/dotfiles) from GitHub

```cmd
cd %USERPROFILE%
git clone https://github.com/stanislavsabev/dotfiles dotfiles
```

## **Environment Variables**

```properties
CODE_BIN_DIR="%LOCALAPPDATA%\Programs\Microsoft VS Code\bin"
CODE_USER_DIR="%APPDATA%\Code\User"
TT_EDITOR=code
TT_DOTFILES_DIR="%USERPROFILE%\dotfiles"
TT_PROJECTS_DIR="%USERPROFILE%\projects"
PYENV="%USERPROFILE%\.pyenv\pyenv-win\"
PYENV_HOME="%USERPROFILE%\.pyenv\pyenv-win\"
PYENV_ROOT="%USERPROFILE%\.pyenv\pyenv-win\"
```

### Add Environment Variables, `scripts` and `aliases` to the `PATH`

- With `cmd` (requires an elevated command prompt)

Syntax: `setx <variable_name> "<variable_value>"`

```cmd
cd .\dotfiles\win
.\install.bat
```

- With `PowerShell`

```pwsh
[System.Environment]::SetEnvironmentVariable('CODE_BIN_DIR', $env:LOCALAPPDATA + "\Programs\Microsoft VS Code\bin","User")
[System.Environment]::SetEnvironmentVariable('CODE_USER_DIR', $env:APPDATA + "\Code\User\","User")
[System.Environment]::SetEnvironmentVariable('TT_DOTFILES_DIR', $env:USERPROFILE + "\dotfiles\","User")
[System.Environment]::SetEnvironmentVariable('TT_PROJECTS_DIR', $env:USERPROFILE + "\projects\","User")
[System.Environment]::SetEnvironmentVariable('PATH', [System.Environment]::GetEnvironmentVariable('PATH', "User") + ";" + $env:TT_DOTFILES_DIR + "\win\scripts;" + $env:TT_DOTFILES_DIR + "\win\scripts\priv;" + $env:TT_DOTFILES_DIR + "\win\aliases","User")
```

## **Setup pyenv**

The default way to install `pyenv-win` requires the use of git commands. You need to install git/git-bash for Windows.
If you are using `PowerShell` or `Git Bash` use `$HOME` instead of `%USERPROFILE%`

```console
git clone https://github.com/pyenv-win/pyenv-win.git "%USERPROFILE%\.pyenv"
```

Add required environment variables

```pwsh
[System.Environment]::SetEnvironmentVariable('PYENV',$env:USERPROFILE + "\.pyenv\pyenv-win\","User")

[System.Environment]::SetEnvironmentVariable('PYENV_ROOT',$env:USERPROFILE + "\.pyenv\pyenv-win\","User")

[System.Environment]::SetEnvironmentVariable('PYENV_HOME',$env:USERPROFILE + "\.pyenv\pyenv-win\","User")
```

Add following paths to user `PATH` variable

```pwsh
[System.Environment]::SetEnvironmentVariable('PATH', $env:USERPROFILE + "\.pyenv\pyenv-win\bin;" + $env:USERPROFILE + "\.pyenv\pyenv-win\shims;" + [System.Environment]::GetEnvironmentVariable('PATH', "User"),"User")
```
