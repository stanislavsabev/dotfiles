function gwt_add
    set -l _self "gwt-add"
    set -l _usage "usage: $_self [-x] [-n] NEW_BRANCH [PATH] COMMIT-ISH
    Add worktree to current project.
    
    -x --extend     Extend. Copies helper directories (like .vscode) from parent dir.
    -n --dry-run    Print the command that would run.
                    Cannot be used with `-x`
    "
    argparse -n $_self -x x,n 'h/help' 'x/extend' 'n/dry-run' -- $argv
    set -l last_status $status

    if set -ql _flag_help
        or test $last_status -ne 0
        echo $_usage
        return $last_status
    end

    set -l argstr
    set -l TARGET_DIR
    switch (count $argv)
        case 1
            set argstr $argv[1]
            set TARGET_DIR $argv[1]
        case 2
            set TARGET_DIR $argv[1]
            set argstr -b $argv[1] $argv[1] $argv[2]
        case 3
            set TARGET_DIR $argv[2]
            set argstr -b $argv[1] $argv[2] $argv[3]
        case '*'
            echo "$_self: invalid arguments"
            echo $_usage
            return $invalid_arguments
    end

    set -l _popd_cmd popd
    if set -ql _flag_dry_run
        set -p _git_pushd echo "dry-run:"
    end

    command $_git_cmd worktree add $argstr

    if set -ql _flag_extend
        pushd $TARGET_DIR
        vscode_add_sett
        popd
    end

end
