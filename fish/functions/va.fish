function va -a venv_name --description "Activate python virtual environment"
    set -l _self "va"
    set -l _usage "usage: $_self [VENV_PATH]
    Activate python virtual environment

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
        return $last_status
    end

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

    set f "$_venv/bin/activate.fish"
    if test -e $f
        source $f
    else
        echo "$_self: '$f' not found "
    end
end
