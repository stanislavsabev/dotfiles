function verify_commit_message
    argparse h/help -- $argv
    set -l last_status $status

    if set -ql _flag_help
        or test $last_status -ne 0
        echo "usage: verify_commit_message [COMMIT_MESSAGE]
    Validate commit message.
    If called without arguments, last commit message in current dir will be evaluated"
        return $last_status
    end

    set -l COMM_MSG
    if test (count $argv) -eq 0
        set COMM_MSG "(git log -1 --pretty=%B)"
    else
        set COMM_MSG "$argv[1]"
    end
    python $SCRIPTS_DIR/verify_commit_msg.py "$COMM_MSG"
end