# Ignore commands starting with space
set -gx HISTIGNORE ' *'
set -gx HISTCONTROL ignoreboth:erasedups
set -gx COLORTERM truecolor

set -gx EDITOR code
set -gx CONFIG_DIR "$HOME/.config"

# Util
set -gx PROJECTS_DIR "$HOME/projects"

# Python
set -gx VENV_NAME ".venv"

switch (uname)
    case Linux

        set -gx DOTFILES_DIR "$HOME/.dotfiles/linux"
        set -gx VBA_PARSER_DIR "$PROJECTS_DIR/vba_parser"

    case Darwin

        set -gx DOTFILES_DIR "$HOME/.dotfiles/macos"

        # Projects
        set -gx BE_DIR "$PROJECTS_DIR/ggrc_be"
        set -gx MIGRATIONS_DIR "$PROJECTS_DIR/ggrc_migrations"
        set -gx Q2C_DIR "$PROJECTS_DIR/q2c"
        set -gx FE_DIR "$PROJECTS_DIR/ggrc_fe"
        set -gx SOA_DIR "$PROJECTS_DIR/soa"

        # Python
        set -gx VENV_MIG_NAME ".vmig"
        set -gx VENV_BE_NAME ".vbe"
        set -gx VENV_SOA_NAME ".vsoa"
        set -gx VENV_Q2C_NAME ".vq2c"
end

set -gx SCRIPTS_DIR "$DOTFILES_DIR/bin"


# Devel
set -gx NVM_DIR "$HOME/.nvm"
# test -s "$NVM_DIR/nvm.sh" && \. bash -c "$NVM_DIR/nvm.sh"  # This loads nvm
# test -s "$NVM_DIR/bash_completion" && \. bash -c "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

set -gx PS_STATE 1
