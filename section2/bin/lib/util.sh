#!/bin/bash

function getarg() {
    NAME=${1}
    while [[ ! -z ${2} ]]; do
        if [[ "--${NAME}" == "${2}" ]]; then
            echo "${3}"
            break
        fi
        shift
    done
}   

function print_ip() {
    IP=$(
        ifconfig ${1} | \
            grep "inet addr:" |\
            awk '{print $2}' |\
            cut -f 2 -d ":"
        )
    echo ${IP}
}

function get_public_ip() {
	dig +short myip.opendns.com @resolver1.opendns.com
}
