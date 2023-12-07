# Ignore commands starting with space
set -gx HISTIGNORE ' *'
set -gx HISTCONTROL ignoreboth:erasedups
set -gx COLORTERM truecolor

set -gx EDITOR code-insiders
set -gx DOTFILES_DIR "$HOME/.dotfiles"
set -gx CONFIG_DIR "$HOME/.config"

# Util
set -gx PROJECTS_DIR "$HOME/projects"

# Python
set -gx VENV_NAME ".venv"

switch (uname)
    case Linux

        set -gx DOTFILES_DIR_OS "$DOTFILES_DIR/linux"
        set -gx VBA_PARSER_DIR "$PROJECTS_DIR/vba_parser"

    case Darwin

        set -gx DOTFILES_DIR_OS "$DOTFILES_DIR/macos"
end

set -gx SCRIPTS_DIR "$DOTFILES_DIR_OS/bin"


# Devel
set -gx NVM_DIR "$HOME/.nvm"
# test -s "$NVM_DIR/nvm.sh" && \. bash -c "$NVM_DIR/nvm.sh"  # This loads nvm
# test -s "$NVM_DIR/bash_completion" && \. bash -c "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

set -gx PS_STATE 1
