function vscode_clear_all
    switch (uname)
        case Linux
            rm -rf "$CONFIG_DIR/Code/Cache/*"
            rm -rf "$CONFIG_DIR/Code/CachedData/*"
        case Darwin
            rm -rf "$HOME/Library/Application Support/Code/Cache/*"
            rm -rf "$HOME/Library/Application Support/Code/CachedData/*"
    end
    vscode_clear_pycache $argv
end
