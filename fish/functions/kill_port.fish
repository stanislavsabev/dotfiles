function kill_port

    for port in (lsof -t -i:$argv[1])
        kill -9 $port
        echo "killed $port"
    end
end