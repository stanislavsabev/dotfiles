function gwt_move --description "Rename worktree"
    set -l _self "gwt-mv"
    set -l options (fish_opt -s h -l help)
    set options $options (fish_opt -s n -l dry-run --long-only)
    argparse $options -- $argv

    if set -ql _flag_help
        or test (count $argv) -ne 2
        echo "usage: $_self [-h] [-n] WORKTREE NEW_WORKTREE
    Rename worktree

    -n --dry-run   print commands that would be executed
    -h --help      print this message
    "
        return $invalid_arguments
    end
    
    set -l git_cmd git
    set -l cd_cmd cd
    if set -ql _flag_dry_run
        set git_cmd echo "dry-run:" $git_cmd
        set cd_cmd echo "dry-run:" $cd_cmd
    end
    
    command $git_cmd worktree move $argv[1] $argv[2]
    $cd_cmd $argv[2]
    command $git_cmd branch -M $argv[2]
    $cd_cmd -
end
