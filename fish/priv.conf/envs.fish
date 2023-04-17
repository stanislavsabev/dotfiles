set -gx PRIV_SCRIPTS_DIR "$SCRIPTS_DIR/priv"
fish_add_path --global --append $PRIV_SCRIPTS_DIR

switch (uname)

case Darwin

    set -gx DOTFILES_DIR_OS "$DOTFILES_DIR/macos"

    # Projects
    set -gx BE_DIR "$PROJECTS_DIR/ggrc_be"
    set -gx MIGRATIONS_DIR "$PROJECTS_DIR/ggrc_migrations"
    set -gx Q2C_DIR "$PROJECTS_DIR/q2c"
    set -gx FE_DIR "$PROJECTS_DIR/ggrc_fe"
    set -gx SOA_DIR "$PROJECTS_DIR/soa"
    set -gx SQL_DIR "$PROJECTS_DIR/sql"
    
    # Python
    set -gx VENV_MIG_NAME ".vmig"
    set -gx VENV_BE_NAME ".vbe"
    set -gx VENV_SOA_NAME ".vsoa"
    set -gx VENV_Q2C_NAME ".vq2c"
end
