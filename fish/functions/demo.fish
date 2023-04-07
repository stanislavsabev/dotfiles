function demo
    argparse  'nam=' -- $argv
    or return

    if set -ql _flag_help
        echo "usage: demo name="
    end

    echo $_flag_nam

end