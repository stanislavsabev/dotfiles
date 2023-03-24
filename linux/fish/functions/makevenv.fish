
function makevenv -a NAME --description "makevenv [NAME=.venv]"
    set -l _usage "usage: makevenv [NAME=.venv]"
    argparse h/help -- $argv
    set -l last_status $status

    if set -ql _flag_help
        or test $last_status -ne 0
        echo $_usage
        return
    end

    set -l argc (count $argv)
    set -l vaname
    if test $argc -eq 0
        set vaname $VENV_NAME
    else
        set vaname $argv[1]
    end

    command python -m venv "$vaname"
    source "$vaname/bin/activate.fish"
end