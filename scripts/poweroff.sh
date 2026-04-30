#!/bin/bash

# Check if the correct number of arguments are supplied
if [ "$#" -eq 3 ]; then
    USERNAME=$1
    HOSTNAME=$2
    KEY_FILE=$3
    ssh -i "${KEY_FILE}" "${USERNAME}@${HOSTNAME}" "poweroff"
elif [ "$#" -eq 2 ]; then
    USERNAME=$1
    HOSTNAME=$2
    ssh "${USERNAME}@${HOSTNAME}" "poweroff"
elif [ "$#" -eq 1 ]; then
    USERNAME=$1
    ssh "${USERNAME}" "poweroff"
else
    echo "Usage: $0 <username> <hostname> [<key_file>]"
    exit 1
fi

sleep 2
