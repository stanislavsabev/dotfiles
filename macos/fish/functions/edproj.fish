function edproj
    argparse 'h/help' 'n/name=' 'p/proj=' -- $argv
    set -l last_status $status

    set -f _name $_flag_name
    set -f _proj $_flag_proj

    set -l _usage "usage: $_name [WORKTREE]
    Open VSCode in current project and worktreee"

    if set -ql _flag_help
        or test $last_status -ne 0
        echo $_usage
        return $last_status
    end

    # If worktree is provided
    if test (count $argv) -ne 0
        set _proj "$_proj/$argv[1]"
    end

    if test -d "$_proj"
        command $EDITOR -n $_proj
    else
        echo "$_name: unknown project $_proj"
        return $no_matches_found
    end
end
