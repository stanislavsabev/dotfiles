
function wt_add
    set -l _name "wt-add"
    set -l _usage "usage: $_name [-ix | -d] [NEW_BRANCH] [PATH] COMMIT-ISH
    Add worktree to current project.
    
    -i --init       Init FE part (applicable to SOA and FE)
    -x --ex         Extend. Copies helper directories (like .vscode) from parent dir.
    -d --dry-run    Print the command that would run.
                    Cannot be used with `-i` or `-x`
    "
    argparse -n $_name -x x,d -x i,d 'h/help' 'i/init' 'x/ex' 'd/dry-run' -- $argv
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

    if set -ql _flag_init
        switch (pwd)
            case $SOA_DIR
                set argv
                cd $TARGET_DIR
                init_soa
                cd -
            case $FE_DIR
                set argv
                cd $TARGET_DIR
                init_fe
                cd -
            case '*'
                echo "$_name: unknown dir for init:" (pwd)
        end
    end

    if set -ql _flag_ex
        cd $TARGET_DIR
        vscode_add_sett
        cd -
    end

end