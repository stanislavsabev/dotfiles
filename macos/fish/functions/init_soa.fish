function _argparse_init_soa
    set -l _usage "usage: init_soa
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

function init_soa --description "Build FE for Auditor"
    _argparse_init_soa $argv; or return
    cd cd $SOA_DIR
    nvm use 8
    rm -rf node_modules
    npm i --unsafe-perm
    command bash -c './bin/build_assets' dummy
    va soa
    envsource './configs/envs/local.env'
    set -gxa PYTHONPATH (pwd)/src
end