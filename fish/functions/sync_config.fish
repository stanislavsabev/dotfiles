function sync_config
    set -l _usage "usage: sync_config [-rd] CONFIG_NAMES..
    Sync config files between their location (SRC) and dotfiles repo (DEST)

    CONFIG_NAMES    NAME_1 ..NAME_N, config names 
                    valid names are: fish, bashrc, tmux, vscode, git
    -r --reverse    reverse copy - from DEST to SRC
    -h --help       displays this message
    --dry-run       print commands that would be executed
    "

    argparse h/help r/reverse dry-run -- $argv
    set -l last_status $status
    set -l argc (count $argv)

    if set -ql _flag_help
        or test $last_status -ne 0
        or test $argc -eq 0
        echo $_usage
        return $last_status
    end

    set -f SRC
    set -f DEST
    set -f FLAGS
    set -f _suffix '.bak'
    set names $argv

    for name in $names
        switch $name

            case fish
                set SRC $__fish_config_dir
                set DEST "$DOTFILES_DIR/fish"
                set FLAGS --exclude ".git*" --exclude "priv"
            case bashrc
                set SRC "$HOME/.bashrc"
                set DEST "$DOTFILES_DIR_OS/bash/.bashrc"
                set FLAGS -b --suffix=$_suffix
            case vscode
                switch (uname)
                    case Linux
                        set SRC "$CONFIG_DIR/Code/User"
                    case Darwin
                        set SRC "$HOME/Library/Application Support/Code/User"
                    case '*'
                        echo "sync_config: $(uname) not supported"
                        return 1
                end
                set DEST "$DOTFILES_DIR_OS/vscode"
                set FLAGS --include snippets/ --include "*.json" --include "*.code-snippets" \
                    --exclude "*" -b --suffix=$_suffix
            case git
                set SRC $HOME
                set DEST "$DOTFILES_DIR/git"
                set FLAGS --include ".git*" --exclude "*"
            case tmux
                set SRC "$HOME/.tmux.conf"
                set DEST "$DOTFILES_DIR/.tmux.conf"
                set FLAGS -b --suffix=$_suffix
            case '*'
                echo "sync_config: Unkown name: $name"
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
