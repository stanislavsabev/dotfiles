
function make_venv -a VENV_PATH --description "make_venv [VENV_PATH]"
    set -l _usage "usage: make_venv [VENV_PATH]

    VENV_PATH  Virtual environment path. If no path is provided,
          the script will check .python-cfg file in current directory
          and take the path from there, finaly will use
          the default path '$VENV_NAME'
    "
    argparse h/help -- $argv
    set -l last_status $status
    if set -ql _flag_help
        or test $last_status -ne 0
        echo $_usage
        return
    end

    set -l argc (count $argv)
    set -l venv_name
    if test $argc -eq 1
        set venv_name "$argv[1]"
    else if test -e .python-cfg
        set venv_name (head -1 .python-cfg)
    else
        set venv_name $VENV_NAME
    end

    python -m venv $venv_name
    source "$venv_name/bin/activate.fish"
end