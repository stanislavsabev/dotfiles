function cdls --description "cd into dir and list it's content"
    argparse 'h/help' -- $argv
    set -l argc (count $argv)
    if set -ql _flag_help
        echo "usage: cdls [DIR_NAME]
    cd into dir and list it's content"
        return 0
    end

    cd $argv
    la
end
