
function runq2c -a BRANCH --description "Run Q2C"
    set -l _usage "usage: runq2c
    Run Q2C
    "
    argparse h/help -- $argv
    set -l last_status $status

    if set -ql _flag_help
        or test $last_status -ne 0
        echo $_usage
        return
    end

    set TARGET_DIR "$PROJECTS_DIR/q2c"
    echo "Starting Q2C..."
    echo "at:  $TARGET_DIR"
    cd $TARGET_DIR
    va "q2c"
    ./bin/run_local.py
end