
function run_dbreset_soa -a BRANCH CONFIG --description "Reset SOA database"
    set -l _usage "usage: run_dbreset_soa [WORKTREE] [--config ENV_FILE]
    Reset SOA database

    WORKTREE     to run specific revision
    -c --config         ENV_FILE
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
        echo "run_dbreset_soa: missing BRANCH|WORKTREE value"
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
        echo "run_dbreset_soa: file not found: $CONFIG_FILE"
        return $invalid_arguments
    end

    va soa
    set -gx PYTHONPATH $PYTHONPATH $TARGET_DIR/src
    envsource $CONFIG_FILE
    set -gx DB_NAME $GGRC_DB_NAME

    echo "Reseting SOA database..."
    echo "at:  $TARGET_DIR"
    echo "DB: $DB_NAME"
    echo "CONFIG: $CONFIG_FILE"

    echo bash -c './bin/db_reset "$@"' dummy -d $DB_NAME
    command bash -c './bin/db_reset "$@"' dummy -d $DB_NAME
end