function gwt
    set -l _self "gwt"
    set -l _usage "usage: $_self [-h] [COMMAND]
    Call worktree command
    
    -h --help   Print this message

    COMMANDS
        a | add 
       co | checkout 
       ls | list  
       mv | move 
       rm | remove 
    clone | 
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
            set _cmd gwt_add 
        case checkout co
            set _cmd gwt_checkout
        case list ls
            set _cmd gwt_list
        case move mv
            set _cmd gwt_move
        case remove rm
            set _cmd gwt_remove
        case clone
            set _cmd gwt_clone
        case '*'
            echo "$_self: unknown command $argv[1]"
            return $invalid_arguments
    end
    $_cmd $orig_argv[2..]
end
