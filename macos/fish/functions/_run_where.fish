function _run_where -a target --description "Helper for run[...] functions"
    argparse 't/target=' -- $argv
    or return $invalid_arguments

    set -l SERVICE_DIR $_flag_target

    set -l WHERE "."
    if test (count $argv) -ne 0
        set WHERE "$argv[1]"
    end

    if test "$WHERE" = "."
        set WHERE (git branch --show-current 2> /dev/null )
        if test -z "$WHERE"
            echo "error: failed to match branch/worktree"
            return $no_matches_found
        end
    end
    echo "$SERVICE_DIR/$WHERE"
    return 0
end