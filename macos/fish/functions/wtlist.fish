function wtlist --description "wt-ls [[GREP_FLAGS] PATTERNS]"
    if test (count $argv) -ne 0
        echo "$( git worktree list | grep $argv | awk '{ print $2" - "$3 }')"
    else
        echo "$( git worktree list | awk '{ print $2" - "$3 }' )"
    end
end