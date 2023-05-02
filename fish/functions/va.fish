function va -a NAME --description "Activate python virtual environment"
    set -l _usage "usage: va [NAME=.venv]
    Activate python virtual environment
    "
    argparse h/help -- $argv
    set -l last_status $status

    if set -ql _flag_help
        or test $last_status -ne 0
        echo $_usage
        return $last_status
    end

    set -l argc (count $argv)
    set -l arg
    if test $argc -eq 0
        set arg $VENV_NAME
    else
        set arg "$argv[1]"
    end

    set f "$arg/bin/activate.fish"
    if test -e $f
        source $f
    else
        echo "va: File not found $f"
    end
end
