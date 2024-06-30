function kafka_up
    set -l _usage "usage: kafka_up [-h]
    Start zookeeper service and Kafka broker

    -h --help   Print this message
    "
    argparse h/help -- $argv
    set -l last_status $status

    if set -ql _flag_help
        or test $last_status -ne 0
        echo $_usage
        return $last_status
    end

    $KAFKA_DIR/bin/zookeeper-server-start.sh $KAFKA_CONFIG_DIR/zookeeper.properties & \
    $KAFKA_DIR/bin/kafka-server-start.sh $KAFKA_CONFIG_DIR/server.properties
end