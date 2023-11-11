function vscode_clear
    set -l _self "vscode_clear"
    set -l _usage "usage: $_self [-n] [-h] [SRC]
    Clear VSCode cache and cache data

    -n --dry-run    prints commands that would be executed
    -h --help       displays this message
    "

    argparse 'h/help' 'n/dry-run' -- $argv
    set -l last_status $status
    set -l argc (count $argv)

    if set -ql _flag_help
        or test $last_status -ne 0
        echo $_usage
        return $last_status
    end

    set -l _cmd rm -rf
    if set -ql _flag_dry_run
        set -p _cmd echo 'dry-run:'
    end

    switch (uname)
        case Linux
            command $_cmd "$CONFIG_DIR/Code/Cache/*"
            command $_cmd "$CONFIG_DIR/Code/CachedData/*"
        case Darwin
            command $_cmd "$HOME/Library/Application Support/Code/Cache/*"
            command $_cmd "$HOME/Library/Application Support/Code/CachedData/*"
    end
    
    if set -ql _flag_dry_run
        echo clear_pycache $argv
    else
        clear_pycache $argv
    end
end
