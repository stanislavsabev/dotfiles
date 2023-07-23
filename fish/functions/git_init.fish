function git_init
    set -l _usage "usage: git_init [name] [email] [dry-run]
    Init git repository
    
    -n --name    local config user.name
    -e --email   local config user.email
    
    -h --help       displays this message
    --dry-run       print commands that would be executed
    "
    set -g orig_argv $argv

    argparse 'n/name' 'e/email' 'h/help' 'dry-run' -- $argv
    set -l last_status $status
    set -l argc (count $argv)

    if set -ql _flag_help
        or test $last_status -ne 0
        echo $_usage
        return $last_status
    end

    set -f _name "stanislavsabev"
    set -f _email "bezraboten.34@gmail.com"
    
    if set -ql _flag_name
        set -f _name $_flag_name
    end

    if set -ql _flag_email
        set -f _email $_flag_email
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
