# Ignore commands starting with space
set -gx HISTIGNORE " *"
set -gx HISTCONTROL ignoreboth:erasedups
set -gx COLORTERM truecolor

set -gx EDITOR code
set -gx DOTFILES_DIR "$HOME/.dotfiles/linux"
set -gx CONFIG_DIR "$HOME/.config"

# Util
set -gx SCRIPTS_DIR "$DOTFILES_DIR/bin"
set -gx PROJECTS_DIR "$HOME/projects"
set -gx CONFIG_DIR "$HOME/.config"

# Projects
set -gx PROJ_DIR "$HOME/projects"
set -gx OPT_DIR "$HOME/opt"

# Python
set -gx VENV_NAME ".venv"

# Devel
set -gx NVM_DIR "$HOME/.nvm"
# test -s "$NVM_DIR/nvm.sh" && \. bash -c "$NVM_DIR/nvm.sh"  # This loads nvm
# test -s "$NVM_DIR/bash_completion" && \. bash -c "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

set -gx PS_STATE 1
