function grep_history --description "grep_history: grep history"
    argparse -i -s 'h/help' -- $argv
    if test (count $argv) -eq 0
        or set -ql _flag_help
        echo "usage: grephist GREP_ARGS"
        return 0
    end
    history | grep $argv
end
