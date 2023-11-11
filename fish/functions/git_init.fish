function git_init
    set -f _name "stanislavsabev"
    set -f _email "bezraboten.34@gmail.com"

    set -l _usage "usage: git_init [--name] [--email] [-n]
    Init git repository with optional local user name and email.

    --name          local user.name='$_name'
    --email         local user.email='$_email'    
    -h --help       displays this message
    -n --dry-run    print commands that would be executed
    "
    set -g orig_argv $argv

    argparse 'name' 'email' 'h/help' 'n/dry-run' -- $argv
    set -l last_status $status
    set -l argc (count $argv)

    if set -ql _flag_help
        or test $last_status -ne 0
        echo $_usage
        return $last_status
    end

    
    if set -ql _flag_name
        set _name $_flag_name
    end

    if set -ql _flag_email
        set _email $_flag_email
    end

    set -l _cmd_init git init
    set -l _cmd_config git_local_config
    set -l _cmd_touch touch
    if set -ql _flag_dry_run
        set -p _cmd_init echo 'dry-run:'
        set -p _cmd_config echo 'dry-run:'
        set -p _cmd_touch echo 'dry-run:'
    end

    command $_cmd_init
    $_cmd_config --name $_name --email $_email
    command $_cmd_touch .gitignore
end
