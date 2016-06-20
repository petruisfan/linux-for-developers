#!/bin/bash

AUX="123"
ARG=${1:-${AUX:-"default value"}}
#echo ${ARG}

LINE="some long lien of text"
#echo ${LINE:5:4}

function print_ip() {
    IP=$(
        ifconfig ${1} | \
            grep "inet addr:" |\
            awk '{print $2}' |\
            cut -f 2 -d ":"
        )
    echo ${IP}
}

function long_running_task_1() {
    sleep 1
}
function long_running_task_2() {
    sleep 2
}

while [[ ! -z ${1} ]]; do
    case "${1}" in
        getip)
            shift 
            ARG=${1}
            print_ip ${ARG}
            shift
            ;;
        parallel)
            long_running_task_1 &
            long_running_task_2 &
            PID=$!
            wait ${PID}
            shift
            ;;
        *)
            echo "Invalid argument"
            exit 1
    esac
    
done    

