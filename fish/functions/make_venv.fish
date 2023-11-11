
function make_venv -a PATH --description "make_venv [PATH]"
    set -l _usage "usage: make_venv [PATH]

    PATH  Virtual environment path. If no path is provided,
          the script will check .python-cfg file in current directory
          and take the path from there, finaly will use
          the default path '$VENV_NAME'
    "
    argparse h/help -- $argv
    set -l last_status $status
    set -l argc (count $argv)

    if set -ql _flag_help
        or test $last_status -ne 0
        echo $_usage
        return
    end

    set -l _venv
    if test $argc -eq 1
        set _venv "$argv[1]"
    else if test -e .python-cfg
        set _venv (head -1 .python-cfg)
    else
        set _venv $VENV_NAME
    end

    command python -m venv "$_venv"
    source "$vaname/bin/activate.fish"
end