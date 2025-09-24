function sync-config
    set -l _self "sync-config"
    set -l _usage "usage: $_self [-h] [-r] [-n] CONFIG_NAMES..
    Sync config files between their location (SRC) and dotfiles repo (DEST)

    CONFIG_NAMES    NAME_1 ..NAME_N, config names 
                    Valid names are: 
                        fish
                        bashrc
                        tmux
                        code
                        code-insiders
                        git
                        alacritty

    -r --reverse    reverse copy - from DEST to SRC
    -n --dry-run    print commands that would be executed
    -h --help       displays this message
    "

    argparse h/help r/reverse n/dry-run -- $argv
    set -l last_status $status
    set -l argc (count $argv)

    if set -ql _flag_help
        or test $last_status -ne 0
        or test $argc -eq 0
        echo $_usage
        return $last_status
    end

    set -f CONF_D
    
    switch (uname)
    case Linux
        set CONF_D $XDG_CONFIG_HOME
    case Darwin
        set CONF_D "$HOME/Library/Application Support"
    case '*'
        echo "$_self: $(uname) not supported"
        return 1
    end

    set -f SRC
    set -f DEST
    set -f FLAGS
    set -f _suffix '.backup'
    set names $argv

    for name in $names
        switch $name
            case fish
                set SRC $__fish_config_dir
                set DEST "$TT_DOTFILES_DIR/fish"
                set FLAGS --exclude ".git*" --exclude "priv"
            case bashrc
                set SRC "$HOME/.bashrc"
                set DEST "$DOTFILES_OS_DIR/bash/.bashrc_$TT_OS"
                set FLAGS -b --suffix=$_suffix
            case code
                set SRC "$CONF_D/Code/User"
                set DEST "$TT_DOTFILES_DIR/code"
                set FLAGS --include snippets/ --include "*.json" --include "*.code-snippets" \
                    --exclude "*" -b --suffix=$_suffix
            case code-insiders
                set SRC "$CONF_D/Code - Insiders/User"
                set DEST "$TT_DOTFILES_DIR/code/code-insiders"
                set FLAGS --include snippets/ --include "*.json" --include "*.code-snippets" \
                    --exclude "*" -b --suffix=$_suffix
            case git
                set SRC $HOME
                set DEST "$TT_DOTFILES_DIR/git"
                set FLAGS --include ".git*" --exclude "*"
            case tmux
                set SRC "$HOME/.tmux.conf"
                set DEST "$TT_DOTFILES_DIR/.tmux.conf"
                set FLAGS -b --suffix=$_suffix
            case alacritty
                set SRC "$CONF_D/alacritty/"
                set DEST "$TT_DOTFILES_DIR/alacritty/"
                set FLAGS -b --suffix=$_suffix
            case '*'
                echo "$_self: Unkown name: $name"
                return $invalid_arguments
        end

        if set -ql _flag_reverse
            set TMP $SRC
            set SRC $DEST
            set DEST $TMP
            set FLAGS --update $FLAGS # skip files that are newer on the reciever
        else
            set FLAGS --checksum --delete $FLAGS # delete files removed form SRC
        end
    end

    set -l _cmd rsync
    if set -ql _flag_dry_run
        set -p _cmd echo 'dry-run:'
    end

    # Append / to SRC if it is directory
    if test -d $SRC
        set SRC "$SRC/"
    end
    command $_cmd -avrh $FLAGS "$SRC" "$DEST"
end
