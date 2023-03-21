
function envsource -a verbose
    set -l _usage "envsource: [--verbose] ENV_FILE
    
    Replacement for the below from bash:
    'set -o allexport && source ./configs/envs/local.env && set +o allexport'.

    -v --verbose    verbose, prints all key=value pairs.
    "
    argparse h/help v/verbose -- $argv
    set -l last_status $status
    
    if set -ql _flag_help
        or test $last_status -ne 0
        echo $_usage
        return
    end
    
    set -l _verbose 0
    if set -ql _flag_verbose
        set _verbose 1
    end

    set -l argc (count $argv)
    if test $argc -ne 1
        echo "envsource: Invalid arguments"
        echo $_usage
        return
    end

    for line in (cat $argv | grep -v '^#' | grep -v '^\s*$')
        set item (string split -m 1 '=' $line)
        set -gx $item[1] (string trim --chars=\'\" $item[2])
        if test $_verbose -eq 1
            echo "$item[1]: $item[2]"
        end
    end
end
