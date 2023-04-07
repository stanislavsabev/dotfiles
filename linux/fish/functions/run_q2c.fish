
function run_q2c -a BRANCH --description "Run Q2C"
    set -l _usage "usage: run_q2c [WORKTREE]
    Run Q2C

    WORKTREE     to run specific revision
    "
    argparse h/help -- $argv
    set -l last_status $status

    if set -ql _flag_help
        or test $last_status -ne 0
        echo $_usage
        return
    end

    set -l TARGET_DIR (_run_where  $argv -t $Q2C_DIR)
    if test $status -ne 0
        echo $_usage
        return $no_matches_found
    end
    
    echo "Starting Q2C..."
    echo "at:  $TARGET_DIR"
    cd $TARGET_DIR
    va "q2c"
    ./bin/run_local.py
end