function grep_history --description "grep_history: grep history"
    argparse -i -s 'h/help' -- $argv
    if test (count $argv) -eq 0
        or set -ql _flag_help
        echo "usage: grephist GREP_ARGS
    grep search in .bashrc_history, uses -n to show line numbers"
        return 0
    end
    history | grep -n $argv
end
