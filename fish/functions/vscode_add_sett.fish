function vscode_add_sett --description "Copy .vscode/ from SRC (../.ignore/) to DEST (curr dir)"
    set -l _usage "usage: vscode_add_sett [--reverse] [--dry-run]
    Add .vscode/ settings from SRC=`../.ignore` to DEST=`curr-dir`

    -r --reverse    reverse copy - from DEST to SRC
    -h --help       displays this message
    --dry-run       prints commands that would be executed
    "

    argparse 'r/reverse' 'h/help' 'dry-run' -- $argv
    set -l last_status $status
    set -l argc (count $argv)

    if set -ql _flag_help
        or test $last_status -ne 0
        echo $_usage
        return $last_status
    end

    set -f SRC ../.ignore/.vscode
    set -f DEST .vscode

    if set -ql _flag_reverse
        set TMP $SRC
        set SRC $DEST
        set DEST $TMP
    end
    if test -d $SRC
        set SRC $SRC/*
    end

    set -l _cmd cp
    if set -ql _flag_dry_run
        set -p _cmd echo 'dry-run:'
    end

    command $_cmd -Ra $SRC $DEST
end