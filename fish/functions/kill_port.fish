function kill_port
    set -l _usage "usage: kill_port --all | PORTS..
    Stop service by port
    "
    argparse h/help a/all -- $argv
    set -l last_status $status

    if set -ql _flag_help
        or test $last_status -ne 0
        echo $_usage
        return $last_status
    end

    set -l ports
    if set -ql _flag_all
        set ports 8080 8082 9090 8083 8085
    else
        set ports $argv
    end

    for port in $ports
        set -l pids (lsof -t -i:$port)
        for pid in $pids
            kill -9 $pid
        end
        echo "port: $port, pids: $pids"
    end
end