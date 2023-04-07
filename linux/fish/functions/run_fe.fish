
function run_fe -a BRANCH --description "Run FE"
    set -l _usage "usage: run_fe [WORKTREE]
    Run FE

    WORKTREE     to run specific revision
    "
    argparse h/help -- $argv
    set -l last_status $status

    if set -ql _flag_help
        or test $last_status -ne 0
        echo $_usage
        return
    end

    set -l TARGET_DIR (_run_where  $argv -t $FE_DIR)
    if test $status -ne 0
        echo $_usage
        return $no_matches_found
    end

    echo "Starting FE..."
    echo "at:  $TARGET_DIR"
    cd $TARGET_DIR
    npm run dev
end