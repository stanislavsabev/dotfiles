function grep_history
    argparse -i -s 'h/help' -- $argv
    if test (count $argv) -eq 0
        or set -ql _flag_help
        echo "usage: grephist ARGS
    search in .bashrc_history using grep.
    -n will show line numbers"
        return 0
    end
    history | grep -n $argv
end
