function vscode_add_sett --description "Copy .vscode/ directory from SRC to current directory"
    set -l _self "vscode_add_sett"
    set -l _usage "usage: $_self [-r] [-n] [-h] [SRC]
    Copy .vscode/ to current directory

    SRC   Optional source path, default is `..`

    -r --reverse    reverse copy - from DEST to SRC
    -n --dry-run    prints commands that would be executed
    -h --help       displays this message
    "

    argparse 'r/reverse' 'h/help' 'n/dry-run' -- $argv
    set -l last_status $status
    set -l argc (count $argv)

    if set -ql _flag_help
        or test $last_status -ne 0
        echo $_usage
        return $last_status
    end

    set -f SRC ../.vscode
    if test $argc -eq 1
        set SRC $argv[1]
    end
    set -f DEST .vscode/

    if set -ql _flag_reverse
        set TMP $SRC
        set SRC $DEST
        set DEST $TMP
    end

    set -l _cmd cp
    if set -ql _flag_dry_run
        set -p _cmd echo 'dry-run:'
    end

    command $_cmd -Ra $SRC $DEST
end