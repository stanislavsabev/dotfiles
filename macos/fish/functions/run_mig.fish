
function run_mig -a BRANCH --description "Run BE migrations"
    set -l _usage "usage: run_mig [WORKTREE]
    Run BE migrations

    WORKTREE     to run specific revision
    "
    argparse h/help -- $argv
    set -l last_status $status

    if set -ql _flag_help
        or test $last_status -ne 0
        echo $_usage
        return
    end

    set -l TARGET_DIR (_run_where  $argv -t $MIGRATIONS_DIR)
    if test $status -ne 0
        echo $_usage
        return $no_matches_found
    end

    echo "Starting MIGRATIONS..."
    echo "at:  $TARGET_DIR"
    cd $TARGET_DIR
    va migrations
    envsource ./configs/envs/local.env
    command flask run --port=8088
end