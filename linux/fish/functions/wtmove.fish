function wtmove
    if test (count $argv) -ne 2
        echo "usage: wt-mv BRANCH NEW_BRANCH"
        return $invalid_arguments
    end

    git worktree move $argv[1] $argv[2]
    cd $argv[2]
    git branch -M $argv[2]
    cd -
end
