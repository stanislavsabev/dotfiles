function cob
    if test (count $argv) -eq 0
        echo "usage: cob [[GREP_FLAGS] PATTERNS]"
        return $invalid_arguments
    end
    git checkout $(git branch | grep $argv)
end