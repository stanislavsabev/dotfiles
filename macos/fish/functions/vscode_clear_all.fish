function vscode-clear-cache
    rm -rf '~/Library/Application Support/Code/Cache/*'
    rm -rf '~/Library/Application Support/Code/CachedData/*'
    vscode_clear_pycache $argv
end
