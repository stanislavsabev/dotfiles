
function make_venv -a venv_path --description "make_venv [VENV_PATH]"
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
    set -l _venv
    if test $argc -eq 1
        set _venv "$argv[1]"
    else if test -e .proj-cfg
        envsource .proj-cfg
        set _venv $VENV_PATH
    else if test -e .python-cfg
        set _venv (head -1 .python-cfg)
    else
        set _venv $VENV_NAME
    end

    python -m venv $venv_name
    source "$venv_name/bin/activate.fish"
end