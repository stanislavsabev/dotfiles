function vscode-clear-cache
    rm -rf "$CONFIG_DIR/Code/Cache/*"
    rm -rf "$CONFIG_DIR/Code/CachedData/*"
    vscode_clear_pycache $argv
end
