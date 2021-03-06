#!/bin/bash
current_path=$(pwd)

# check broker
function check_broker(){
    echo "check broker service "
    
    if [[ ! -e ${current_path}/conf/application-prod.properties ]];then
        echo "${current_path}/conf/application-prod.properties not exist"
        exit 1        
    fi
    
    port=$(grep "server.port" ${current_path}/conf/application-prod.properties| awk -F'=' '{print $2}' | sed s/[[:space:]]//g)
    if [[ $? -ne 0 ]];then
        echo "get broker port fail"
        exit 1
    fi
    
    exist_topic=$(curl -s "http://127.0.0.1:$port/weevent/rest/exist?topic=hello")
    if [[ "${exist_topic}" == "true" || "${exist_topic}" == "false" ]];then
        echo "broker service is ok"
    else
        echo "broker service is error"
    fi
}

check_broker
