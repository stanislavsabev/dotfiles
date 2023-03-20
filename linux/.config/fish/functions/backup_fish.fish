function backup_fish
    command rsync -rvh --exclude=".*" "$CONFIG_DIR/fish/" "$DOTFILES_DIR/.config/fish/"
end