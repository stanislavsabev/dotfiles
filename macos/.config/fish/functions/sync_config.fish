function sync_config --description "sync_config NAMES.. [--back]"
    set -l _usage "usage: sync_config --names NAMES=<name_1[,name_n]> [--back]

    Syncs app's config files (SRC) to user's `.dotfiles` (DEST)

    NAMES       config names <NAME [..NAME_N]>, valid names: fish, vscode
    -b --back   copy backwards - from DEST to SRC
    -h --help   displays this message
    "

    argparse 'h/help' 'b/back' -- $argv
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
                set SRC "$HOME/Library/Application Support/Code/User/"
                set DEST "$DOTFILES_DIR/.config/Code/User/"
                set FLAGS --include="snippets/" --include "*.json" --include "*.code-snippets" --exclude "*"

            case fish
                set SRC "$CONFIG_DIR/fish/"
                set DEST "$DOTFILES_DIR/.config/fish/"
                set FLAGS --exclude ".git*"
            case '*'
                echo "sync_config: Unkown name: $name"
                return $invalid_arguments
        end

        if set -ql _flag_back
            set TMP $SRC
            set SRC $DEST
            set DEST $TMP
        else
            set FLAGS --delete $FLAGS
        end
    end
    echo command rsync -rvh $FLAGS "$SRC" "$DEST"
    command rsync -rvh $FLAGS "$SRC" "$DEST"
end
