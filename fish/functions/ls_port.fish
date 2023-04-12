function ls_ports    set -l _usage "usage: ls_port [PORTS..]
    Stop service by port

    Default ports 8080 8082 9090 8083 8085
    "
    argparse h/help a/all -- $argv
    set -l last_status $status

    if set -ql _flag_help
        or test $last_status -ne 0
        echo $_usage
        return $last_status
    end

    set -l ports
    if test (count $argv) -eq 0
        set ports 8080 8082 9090 8083 8085
    else
        set ports $argv
    end

    for port in $ports
        set -l pids (lsof -t -i:$port)
        echo "port: $port, pids: $pids"
    end
end