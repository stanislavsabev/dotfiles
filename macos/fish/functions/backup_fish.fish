function backup_fish
    command rsync -rvh --exclude=".git*" "$CONFIG_DIR/fish/" "$DOTFILES_DIR/.config/fish/"
end
