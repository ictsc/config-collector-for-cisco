#!/bin/bash

USER=$1
HOST=$2
PASSWORD=$3

MAX_LINES=100000

expect -c "
set timeout 5
spawn ssh -o \"StrictHostKeyChecking no\" ${USER}@${HOST} show run

expect -nocase \"password:\"
send \"${PASSWORD}\n\"
interact
exit
" | grep -A $MAX_LINES "Current" | grep -B $MAX_LINES "end"
