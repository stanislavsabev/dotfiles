
function wtadd
    set -l _usage "usage: wt-add [NEW_BRANCH] [PATH] COMMIT-ISH"
    argparse 'h/help' -- $argv
    or return
    set -l last_status $status

    if set -ql _flag_help
        or test $last_status -ne 0
        echo "usage: wt-add"
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
            echo "wt-add: invalid arguments"
            echo $_usage
            return $invalid_arguments
        end
    command git worktree add $argstr
end
