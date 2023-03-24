function wtcheckout
    if test (count $argv) -eq 0
        echo "usage: wt-co CHANGE_ID"
        return $invalid_arguments
    end
    set -l curr_branch 
    eval (echo "$argv" | sed -E "s/-b change-[0-9]+/-B (git curr-branch)/")
end
