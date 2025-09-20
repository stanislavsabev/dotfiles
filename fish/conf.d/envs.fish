# Ignore commands starting with space
set -gx HISTIGNORE ' *'
set -gx HISTCONTROL ignoreboth:erasedups
set -gx COLORTERM truecolor

set -gx TT_EDITOR code
set -gx TT_DOTFILES_DIR "$HOME/.dotfiles"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx TT_KAFKA_DIR "$HOME/kafka_2.12-3.7.0"
set -gx TT_KAFKA_CONFIG_DIR "$TT_KAFKA_DIR/config"

# Util
set -gx TT_PROJECTS_DIR "$HOME/projects"

# Python
set -gx VENV_NAME ".venv"

switch (uname)
    case Linux

        set -gx DOTFILES_OS_DIR "$TT_DOTFILES_DIR/linux"
        set -gx VBA_PARSER_DIR "$TT_PROJECTS_DIR/vba_parser"

    case Darwin

        set -gx DOTFILES_OS_DIR "$TT_DOTFILES_DIR/macos"
end

set -gx TT_SCRIPTS_DIR "$DOTFILES_OS_DIR/bin"


# Devel
set -gx NVM_DIR "$HOME/.nvm"
# test -s "$NVM_DIR/nvm.sh" && \. bash -c "$NVM_DIR/nvm.sh"  # This loads nvm
# test -s "$NVM_DIR/bash_completion" && \. bash -c "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

set -gx PS_STATE 1
