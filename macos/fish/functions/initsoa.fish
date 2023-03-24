function _argparse_initsoa
    set -l _usage "usage: initsoa
    Build FE for Auditor
    "
    argparse h/help -- $argv
    set -l last_status $status

    if set -ql _flag_help
        or test $last_status -ne 0
        echo $_usage
        return 1
    end
end

function initsoa --description "Build FE for Auditor"
    _argparse_initsoa $argv; or return
    nvm use 8
    rm -rf node_modules
    npm i --unsafe-perm
    command bash -c './bin/build_assets' dummy
    va soa
    envsource './configs/envs/local.env'
    set -gxa PYTHONPATH "(pwd)/src"
end