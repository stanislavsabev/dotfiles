function wtcheckout
    if test (count $argv) -eq 0
        echo "usage: wt-co CHANGE_ID"
        return $invalid_arguments
    end
    eval (echo $argv[1] | sed -E 's/-b change-[0-9]+/-B $(git curr-branch)/')
end
