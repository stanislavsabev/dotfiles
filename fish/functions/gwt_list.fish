function gwt_list --description "List worktrees in current project"
    set -l _self "gwt-ls"
    set -l _usage "usage: $_self [[GREP_FLAGS] PATTERNS..]
    List worktrees in current project
    "
    argparse -n $_self -i 'h/help' -- $argv
    set -l last_status $status

    if set -ql _flag_help
        or test $last_status -ne 0
        echo $_usage
        return $last_status
    end

    if test (count $argv) -ne 0
        git worktree list | awk '{ print $2" - "$3 }' | grep $argv
    else
        git worktree list | awk '{ print $2" - "$3 }'
    end
end