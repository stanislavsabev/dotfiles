
function run_dbreset_be -a BRANCH --description "Reset BE database"
    set -l _usage "usage: run_dbreset_be [BRANCH|WORKTREE]
    Reset BE database

    BRANCH|WORKTREE     to run specific revision"
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
    cd $TARGET_DIR
    va migrations

    echo "Reseting BE database..."
    echo "at:  $TARGET_DIR"
    #TODO: echo "DB: $DB_NAME"
    command bash -c './scripts/db_init.sh "$@"' dummy
end