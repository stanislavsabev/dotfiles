function git_local_config
    set -l _usage "usage: git_local_config [-h] --name \"NAME\" --email EMAIL"
    
    set -l argc (count $argv)
    echo $argc
    argparse 'h/help' 'n/name=' 'e/email=' -- $argv
    set -l last_status $status

    if set -ql _flag_help
        or test $last_status -ne 0
        or test $argc -eq 0
        echo $_usage
        return $last_status
    end

    if set -q _flag_name
        echo git config --local user.name "$_flag_name"
        command git config --local user.name "$_flag_name" 
    end

    if set -q _flag_email
        echo git config --local user.email "$_flag_email"
        command git config --local user.email "$_flag_email" 
    end
end