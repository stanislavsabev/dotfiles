function kafka_down
    set -l _usage "usage: kafka_down [-h]
    Stop zookeeper service and Kafka broker

    -h --help   Print this message
    "
    argparse h/help -- $argv
    set -l last_status $status

    if set -ql _flag_help
        or test $last_status -ne 0
        echo $_usage
        return $last_status
    end

    $KAFKA_DIR/bin/kafka-server-stop.sh
    $KAFKA_DIR/bin/zookeeper-server-stop.sh
end