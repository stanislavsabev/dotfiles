
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

    set -l WHERE
    set -l TARGET_DIR "."
    set -l argc (count $argv)
    if test $argc -ne 0
        set WHERE $argv[1]
    else
        set WHERE (git branch --show-current)
    end
    if test -z "$WHERE"
        echo _usage
        return $no_matches_found
    end
    if test $WHERE != "."
        set TARGET_DIR "$BE_DIR/$WHERE"
    end

    echo "Starting 'ggrc_migrations' at '$WHERE'..."
    cd $TARGET_DIR
    va migrations
    envsource ./configs/envs/local.env
    command flask run --port=8088
end