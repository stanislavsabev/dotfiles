function gwt_clone --description "Clone repo and set it up as .bare"
    set -l _self "gwt-clone"
    set -l _usage "usage: $_self [-h] [-n] REPO [DIR=.] [--git-opts STRING]
    Clone repo and set it up as .bare

    -h --help     Prints this message
    -n --dry-run  Prints commands that would be executed
    -o --origin   Remote name, default is origin
    -g --git-opts String with options to be passed to git clone
    "
    set -l options (fish_opt -s h -l help)
    set options $options (fish_opt -s n -l dry-run)
    set options $options (fish_opt -s g -l git-opts --long-only --required-val)
    set options $options (fish_opt -s o -l origin --required-val)
    argparse -n $_self -i $options -- $argv
    set -l last_status $status
    set -l argc (count $argv)

    if set -ql _flag_help
        or test $last_status -ne 0
        or test $argc -eq 0
        echo $_usage
        return $last_status
    end

    set -l _repo $argv[1]
    set -l _dir .
    if test $argc -eq 2
        set _dir $argv[2]
    end
    
    set -l git_cmd git
    set -l cd_cmd cd
    set -l popd_cmd popd
    set -l mkdir_cmd mkdir
    
    if set -ql _flag_dry_run
        set  -p git_cmd echo "dry-run:"
        set  -p cd_cmd echo "dry-run:"
        set  -p mkdir_cmd echo "dry-run:"
    end

    if [ "$_dir" != "." ]
        command $mkdir_cmd $_dir
        command $cd_cmd $_dir
    end

    set -f _git_opts
    if set -ql _flag_git_opts
        set _git_opts $_flag_git_opts
    end
    set -f _origin origin
    if set -ql _flag_origin
        set _origin $_flag_origin
    end

    command $git_cmd clone --bare $_git_opts -- $_repo .bare

    if set -ql _flag_dry_run
        echo "dry-run: echo "gitdir: ./.bare" > .git"
    else
        echo "gitdir: ./.bare" > .git
    end
    command $git_cmd config remote.$_origin.fetch "+refs/heads/*:refs/remotes/$_origin/*"
    command $git_cmd fetch $_origin
end
