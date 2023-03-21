
function runmig -a BRANCH --description "usage: runmig [BRANCH|WORKTREE]"
    set -l _usage "usage: runmig [BRANCH|WORKTREE] - runs ggrc_migrations

    BRANCH|WORKTREE     Use to run specific revision."
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

    echo "Starting 'ggrc_migrations'..."
    echo "at:  $TARGET_DIR"
    cd $TARGET_DIR
    va migrations
    envsource ./configs/envs/local.env
    command flask run --port=8088
end