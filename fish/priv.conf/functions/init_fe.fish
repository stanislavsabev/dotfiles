function _argparse_init_fe
    set -l _usage "usage: init_fe
    Build FE for Manager
    "
    argparse h/help -- $argv
    set -l last_status $status

    if set -ql _flag_help
        or test $last_status -ne 0
        echo $_usage
        return 1
    end
end

function init_fe --description "Build FE for Manager"
    _argparse_init_fe $argv; or return
    nvm use 12
    rm -rf node_modules
    npm i bower -g
    npm i
end