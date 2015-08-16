#!/bin/bash

USER=$1
HOST=$2
PASSWORD=$3

expect -c "
set timeout 5
spawn ssh -o \"StrictHostKeyChecking no\" ${USER}@${HOST} show run

expect -nocase \"password:\"
send \"${PASSWORD}\n\"
interact
exit
" | grep -A -1 "!Command:"
