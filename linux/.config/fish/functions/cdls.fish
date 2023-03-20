function cdls --description "cd into dir and list it's content"
    argparse 'h/help' -- $argv
    
    if test (count $argv) -eq 0
        or set -ql _flag_help
        echo "usage: cdls DIRNAME -> cd into dir and list it's content"
        return 0
    end

    cd $argv[1]
    la
end
