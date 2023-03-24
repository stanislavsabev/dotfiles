
function wtadd
    set -f _name wt-add
    set -l _usage "usage: $_name [-ix] [NEW_BRANCH] [PATH] COMMIT-ISH
    Add worktree-branch to current project.
    
    -i --init       Init FE part (applicable to SOA and FE)
    -x --ex         Extend. Copies helper directories from parent dir.
                        (.vscode/, ...)"
    argparse -n $_name h/help i/init x/ex -- $argv
    set -l last_status $status

    if set -ql _flag_help
        or test $last_status -ne 0
        echo $_usage
        return $last_status
    end

    set -l argstr
    switch (count $argv)
        case 1
            set argstr $argv[1]
            # do nothing
        case 2
            set argstr -b $argv[1] $argv[1] $argv[2]
        case 3
            set argstr -b $argv[1] $argv[2] $argv[3]
        case '*'
            echo "$_name: invalid arguments"
            echo $_usage
            return $invalid_arguments
    end
    command git worktree add $argstr

    if set -ql _flag_init
        switch (pwd)
            case $SOA_DIR
                echo initsoa
            case $FE_DIR
                echo initfe
            case '*'
                echo "$_name: unknown dir for init:" (pwd)
        end
    end

    if set -ql _flag_init
        vscode_add_sett
    end

end
