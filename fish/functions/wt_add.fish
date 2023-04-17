
function wt_add
    set -l _name "wt-add"
    set -l _usage "usage: $_name [-ex | -dry-run] [NEW_BRANCH] [PATH] COMMIT-ISH
    Add worktree to current project.
    
    -x --ex         Extend. Copies helper directories (like .vscode) from parent dir.
    -d --dry-run    Print the command that would run.
                    Cannot be used with `-x`
    "
    argparse -n $_name -x x,d 'h/help' 'x/ex' 'd/dry-run' -- $argv
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
            echo "$_name: invalid arguments"
            echo $_usage
            return $invalid_arguments
    end

    set -l _cmd git
    if set -ql _flag_dry_run
        set -p _cmd echo "dry-run:"
    end

    command $_cmd worktree add $argstr

    if set -ql _flag_ex
        cd $TARGET_DIR
        vscode_add_sett
        cd -
    end

end
