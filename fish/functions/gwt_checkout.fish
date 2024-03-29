function gwt_checkout
    set -l _self "gwt-co"
    set -l _usage "usage: $_self \"CHANGE_ID\"
    Checkout CHANGE_ID from Gerrit.
    Note: surround it with quotes
    "
    argparse -n $_self 'h/help' -- $argv
    set -l last_status $status

    if set -ql _flag_help
        or test $last_status -ne 0
        echo $_usage
        return $last_status
    end

    if test (count $argv) -eq 0
        echo $_usage
        return $invalid_arguments
    end
    set -l curr_branch 
    eval (echo "$argv" | sed -E "s/-b change-[0-9]+/-B (git curr-branch)/")
end
