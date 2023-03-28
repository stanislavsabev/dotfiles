function cdup_ls --description "cdup_ls cd into parent dir and list it"
    argparse 'h/help' -- $argv
    
    if test (count $argv) -ne 0
        or set -ql _flag_help
        echo "usage: ..ls
    cd into parent dir and list it's contents"
        return 0
    end

    cd ..
    la
end
