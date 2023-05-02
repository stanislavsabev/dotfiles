function wt
    set -l _usage "usage: wt [COMMAND]
    Call worktree command
    
    COMMAND
    add      | a
    checkout | co
    list     | ls 
    move     | mv
    remove   | rm
    "
    set -g orig_argv $argv

    argparse -s -i h/help -- $argv
    set -l last_status $status
    set -l argc (count $argv)

    if set -ql _flag_help
        and test $argc -eq 0
        or test $last_status -ne 0
            echo $_usage
            return $last_status
    end
    
    set -l _cmd
    switch $argv[1]
        case add a
            set _cmd wt_add 
        case checkout co
            set _cmd wt_checkout
        case list ls
            set _cmd wt_list
        case move mv
            set _cmd wt_move
        case remove rm
            set _cmd wt_remove
        case '*'
            echo "wt: unknown command $argv[1]"
            return $invalid_arguments
    end
    $_cmd $orig_argv[2..]
end
