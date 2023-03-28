#!/usr/bin/env bash

PROJ_DIR="$HOME/projects"
PS3="Select service to start: "

select service in "be" "migration" "fe" "be_db_init" \
    "soa" "soa_db_reset" "fe-for-ui-tests" "q2c" "quit"
do
    if [[ $service == "be" ]]
      then
        start-be "master"
    elif [[ $service == "migration" ]]
      then
        start-migrations "master"
    elif [[ $service == "fe" ]]
      then
        start-fe
    elif [[ $service == "be_db_init" ]]
      then
        start-be-db-init "master"
    elif [[ $service == "soa" ]]
      then		
        start-soa
    elif [[ $service == "soa_db_reset" ]]
      then		
        start-soa-db-reset
    elif [[ $service == "fe-for-ui-tests" ]]
      then
        start-fe-for-ui-tests
    elif [[ $service == "q2c" ]]
      then		
        start-q2c
    elif [[ $service == "quit" ]]
      then	
        echo "Exiting..."
    else
        echo "No service chosen."
    fi
    break
done
