function _wtremove_usage --description wt-rm_usage
    echo "usage: wt-rm [NAMES...] [--force] [--grep [GREP_FLAGS] PATTERNS]
    
    --force     force removal, even if worktree is dirty or locked
    --grep      use to match and remove multiple worktrees, ignores all previous args
    -h --help   displays this message
    "
end


function wtremove --description "wt-rm [NAMES...] [--force] [--grep [GREP_FLAGS] PATTERNS]"

    set -l options (fish_opt -s h -l help)
    set options $options (fish_opt -s f -l force --long-only)
    # set options $options (fish_opt -s g -l grep --long-only --required-val --multiple-vals)
    argparse -n wt-rm -i $options -- $argv
    set -l last_status $status

    if set -ql _flag_help
        or test $last_status -ne 0
        or test (count $argv) -eq 0
        _wtremove_usage
        return $last_status
    end

    set -l FORCE
    if set -ql _flag_force
        set FORCE --force
    end

    set -l NAMES $argv

    # Check if --grep is in argv
    set -l grep_ndx (contains -i -- "--grep" $NAMES)
    if test $status -eq 0
        echo "grep index: $grep_ndx"

        # get arguments after --grep
        # ignore everyting before that
        set argv $argv[(math $grep_ndx + 1)..-1]
        echo "argv: $argv"

        if test (count $argv) -eq 0
            echo "grep: missing arguments"
            _wtremove_usage
            return $invalid_arguments
        end

        set NAMES (git worktree list | \
            awk '{print $NF}' | \
                    grep $argv | \
                    sed -e 's/\[//g' -e 's/\]//g'
            )
        if test (count $NAMES) -eq 0
            echo "wt-rm: Cannot find worktrees with pattern '$argv'"
            return $no_matches_found
        end
    end

    for name in $NAMES
        set name (string trim -r -c / $name)
        command git worktree remove $name
        command git branch -D $name
    end
end