function _argparse_initfe
    set -l _usage "usage: initfe
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

function initfe --description "Build FE for Manager"
    _argparse_initfe $argv; or return
    nvm use 12
    rm -rf node_modules
    npm i bower -g
    npm i
end