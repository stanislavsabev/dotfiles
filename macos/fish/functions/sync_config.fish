function sync_config --description "sync_config NAMES.. [--back]"
    set -l _usage "usage: sync_config NAMES.. [--back]

    Syncs app's config files (SRC) to user's `.dotfiles` (DEST)

    NAMES       NAME_1 ..NAME_N, valid configs names: fish, vscode
    -b --back   reverse copy - from DEST to SRC
    -h --help   displays this message
    "

    argparse 'h/help' 'b/back' 'p/echo' -- $argv
    set -l last_status $status
    set -l argc (count $argv)

    if set -ql _flag_help
    or test $last_status -ne 0
    or test $argc -eq 0
        echo $_usage
        return $last_status
    end

    set -l SRC
    set -l DEST
    set -l FLAGS
    set names $argv
    
    for name in $names
        switch $name
            case vscode
                set SRC "$HOME/Library/Application Support/Code/User"
                set DEST "$DOTFILES_DIR/.config/Code/User"
                set FLAGS --include="snippets/" --include "*.json" --include "*.code-snippets" --exclude "*"

            case fish
                set SRC "$CONFIG_DIR/fish"
                set DEST "$DOTFILES_DIR/.config/fish"
                set FLAGS --exclude ".git*"
            case '*'
                echo "sync_config: Unkown name: $name"
                return $invalid_arguments
        end

        if set -ql _flag_back
            set TMP $SRC
            set SRC $DEST
            set DEST $TMP
            set FLAGS --update $FLAGS # skip files that are newer on the reciever
        else
            set FLAGS --checksum --delete $FLAGS # delete files removed form SRC
        end
    end

    if set -ql _flag_echo
        echo COMMAND: rsync -avrh $FLAGS "$SRC/" "$DEST"
    end
    command rsync -avrh $FLAGS "$SRC/" "$DEST"
end
