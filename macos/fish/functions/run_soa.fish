
function run_soa -a WORKTREE CONFIG --description "Run SOA"
    set -l _usage "usage: run_soa [WORKTREE] [--config ENV_FILE]
    Run SOA

    WORKTREE     to run specific revision
    -c --config  ENV_FILE
    "
    argparse h/help 'c/config=' -- $argv
    set -l last_status $status

    if set -ql _flag_help
        or test $last_status -ne 0
        echo $_usage
        return
    end

    set -l TARGET_DIR (_run_where  $argv -t $SOA_DIR)
    if test $status -ne 0
        echo "run_soa: missing WORKTREE value"
        echo $_usage
        return $no_matches_found
    end
    cd $TARGET_DIR

    set -l CONFIG_FILE "./configs/envs/local.env"
    if set -ql _flag_config
        set CONFIG_FILE $_flag_config
        echo "config file" $CONFIG_FILE
    end
    if not test -e $CONFIG_FILE
        echo "run_soa: file not found: $CONFIG_FILE"
        return $invalid_arguments
    end

    va soa
    set -gx PYTHONPATH $PYTHONPATH ./src
    envsource $CONFIG_FILE
    cd "src"

    echo "Starting SOA..."
    echo "at:  $TARGET_DIR"
    echo "CONFIG: $CONFIG_FILE"
    command flask run --port=9090 --without-threads
end