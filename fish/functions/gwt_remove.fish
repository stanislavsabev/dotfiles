function gwt_remove --description "Remove worktree"
    set -l _self "gwt-rm"
    set -l _usage "usage: $_self [-h] [-n] [NAMES...] [--force] [--grep [GREP_FLAGS] PATTERNS]
    Remove worktree
    
    -h --help   displays this message
    -n --dry-run   print commands that would be executed
    --force     force removal, even if worktree is dirty or locked
    --grep      use to match and remove multiple worktrees, ignores all previous args
    "

    set -l options (fish_opt -s h -l help)
    set -l options (fish_opt -s n -l dry-run)
    set options $options (fish_opt -s f -l force --long-only)
    set options $options (fish_opt -s g -l grep --long-only --required-val --multiple-vals)
    argparse -n $_self -i $options -- $argv
    set -l last_status $status

    if set -ql _flag_help
        or test $last_status -ne 0
        or test (count $argv) -eq 0
        echo $_usage
        return $last_status
    end

    set -l FLAGS
    if set -ql _flag_force
        set FLAGS --force
    end

    set -l git_cmd git
    if set -ql _flag_dry_run
        set git_cmd echo "dry-run:" $git_cmd
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
            echo $_usage
            return $invalid_arguments
        end

        set NAMES (git worktree list | \
            awk '{print $NF}' | \
                    grep $argv | \
                    sed -e 's/\[//g' -e 's/\]//g'
            )
        if test (count $NAMES) -eq 0
            echo "$_self: Cannot find worktrees with pattern '$argv'"
            return $no_matches_found
        end
    end

    for name in $NAMES
        set name (string trim -r -c / $name)
        command $git_cmd worktree remove $FLAGS $name
        command $git_cmd branch -D $name
    end
end
