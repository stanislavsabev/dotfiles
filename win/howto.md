# **HOWTO**

## **Environment Variables**

Easiest is to use PowerShell here
1. Add `DOTFILES_DIR` to the Environment Variables

   ```pwsh
   [System.Environment]::SetEnvironmentVariable('DOTFILES_DIR',$env:USERPROFILE + "\dotfiles\","User")
   ```
2. Add the scripts path to the PATH variable

   ```pwsh
   [System.Environment]::SetEnvironmentVariable('path', [System.Environment]::GetEnvironmentVariable('path', "User") + ";" + $env:USERPROFILE + "\dotfiles\win\scripts","User")
   ```

## **Setup pyenv**

The default way to install pyenv-win, it needs git commands you need to install git/git-bash for windows
If you are using PowerShell or Git Bash use `$HOME` instead of `%USERPROFILE%`

    ```console
    git clone https://github.com/pyenv-win/pyenv-win.git "%USERPROFILE%\.pyenv"
    ```

    ```bash
    git clone https://github.com/pyenv-win/pyenv-win.git "$HOME/.pyenv"
    ```

1. Adding PYENV, PYENV_HOME and PYENV_ROOT to your Environment Variables

   ```pwsh
   [System.Environment]::SetEnvironmentVariable('PYENV',$env:USERPROFILE + "\.pyenv\pyenv-win\","User")

   [System.Environment]::SetEnvironmentVariable('PYENV_ROOT',$env:USERPROFILE + "\.pyenv\pyenv-win\","User")

   [System.Environment]::SetEnvironmentVariable('PYENV_HOME',$env:USERPROFILE + "\.pyenv\pyenv-win\","User")
   ```

2. Now adding the following paths to your USER PATH variable in order to access the pyenv command

   ```pwsh
   [System.Environment]::SetEnvironmentVariable('path', $env:USERPROFILE + "\.pyenv\pyenv-win\bin;" + $env:USERPROFILE + "\.pyenv\pyenv-win\shims;" + [System.Environment]::GetEnvironmentVariable('path', "User"),"User")
   ```