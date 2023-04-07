function findb
    if test (count $argv) -eq 0
        echo "usage: findb [[GREP_FLAGS] PATTERNS..]"
        return $invalid_arguments
    end
    git branch | grep $argv
end