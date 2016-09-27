#!/bin/bash

AUX="123"
ARG=${1:-${AUX:-"default value"}}
#echo ${ARG}

LINE="some long line of text"
#echo "${LINE:5:4}"

function print_ip() {
  IP=$(ifconfig ${1} |\
    grep 'inet addr:' |\
    awk '{print $2}' | \
    cut -f 2 -d ":")
  echo ${IP}
}

function long_running_task_1() {
  sleep 1
}

function long_running_task_2() {
  sleep 2
}

while [[ ! -z ${1} ]]; do
  case "$1" in
    --ip|-i)
      print_ip ${2}
      shift
      shift
      ;;
    --parallel|-p)
      long_running_task_1 &
      long_running_task_2 &
      PID=$!
      wait ${PID}
      notify-send script.sh "execution finished"
      shift
      ;;
    --help|-h)
      echo "This is a help message"
      shift
      ;;
    *)
      echo "Invalid option"
      exit 1
      ;;
  esac
done
