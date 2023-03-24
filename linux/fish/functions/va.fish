
function va -a NAME --description "va [VENV_PATH]"
    set -l _usage "usage: va [VENV_PATH]"
    argparse h/help -- $argv
    set -l last_status $status

    if set -ql _flag_help
        or test $last_status -ne 0
        echo $_usage
        return
    end

    set -l argc (count $argv)
    set -l vaname $VENV_DIR
    if test $argc -eq 0
        set -l vaname $VENV_DIR
    else
        set vaname $argv[1]
    end

    source "./$vaname/bin/activate.fish"
end