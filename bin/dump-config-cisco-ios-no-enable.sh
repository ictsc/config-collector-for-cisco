#!/bin/bash

USER=$1
HOST=$2
PASSWORD=$3

MAX_LINES=100000

expect -c "
set timeout 5
spawn ssh -o \"StrictHostKeyChecking no\" ${USER}@${HOST}

expect -nocase \"password:\"
send \"${PASSWORD}\n\"

expect \"#$\"
send \"terminal length 0\n\"

expect \"#$\"
send \"show run\n\"

expect \"end\r\n\"
expect \"#$\"
exit
" | grep -A $MAX_LINES "Current" | grep -B $MAX_LINES "^end\r$"
