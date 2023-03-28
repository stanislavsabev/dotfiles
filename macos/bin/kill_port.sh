#!/bin/bash

PORT=$1

for OUTPUT in $(lsof -t -i:$PORT)
do
	kill -9 $OUTPUT
	echo "Killed $OUTPUT"
done