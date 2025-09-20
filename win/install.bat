@echo off
setx CODE_BIN_DIR "%LOCALAPPDATA%\Programs\Microsoft VS Code\bin"
setx CODE_USER_DIR "%APPDATA%\Code\User"
setx TT_EDITOR code
setx TT_DOTFILES_DIR "%USERPROFILE%\dotfiles"
setx TT_PROJECTS_DIR "%USERPROFILE%\projects"
setx PYENV "%USERPROFILE%\.pyenv\pyenv-win\"
setx PYENV_HOME "%USERPROFILE%\.pyenv\pyenv-win\"
setx PYENV_ROOT "%USERPROFILE%\.pyenv\pyenv-win\"
setx PATH "%USERPROFILE%\.pyenv\pyenv-win\shims;%USERPROFILE%\.pyenv\pyenv-win\bin;%PATH%;%TT_DOTFILES_DIR%\win\aliases\;%TT_DOTFILES_DIR%\win\scripts\;%TT_DOTFILES_DIR%\win\scripts\priv"
