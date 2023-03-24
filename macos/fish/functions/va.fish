
function va -a NAME --description "va [NAME=.venv]"
    set -l _usage "usage: va [NAME=.venv]"
    argparse h/help -- $argv
    set -l last_status $status

    if set -ql _flag_help
        or test $last_status -ne 0
        echo $_usage
        return
    end

    set -l argc (count $argv)
    set -l arg
    if test $argc -eq 0
        set arg $VENV_NAME
    else
        set arg "$argv[1]"
    end
    
    set -l vaname
    switch $arg
        case "mig" "migrations"
            set vaname "$MIGRATIONS_DIR/$VENV_MIG_NAME"
        case "be"
            set vaname "$BE_DIR/$VENV_BE_NAME"
        case "soa" "auditor"
            set vaname "$SOA_DIR/$VENV_SOA_NAME"
        case "q2c"
            set vaname "$Q2C_DIR/$VENV_Q2C_NAME"
        case $VENV_NAME
            set vaname $VENV_NAME
        case '*'
            set vaname $arg
    end
    source "$vaname/bin/activate.fish"
end