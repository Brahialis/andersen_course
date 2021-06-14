#!/usr/bin/env bash

set -Eexuo pipefail

# Along with "set -E" option, allows to catch ERR traps which do not fire in certain scenarios (even with "set -e")
#trap ERR_TRAP ERR

#ERR_TRAP () {
#       trap - ERR
#       echo "Something went wrong. Error trap fired, please investigate it!"
#}

# sudo netstat -tunapl | awk '/firefox/ {print $5}' | cut -d: -f1 | sort | uniq -c | sort | tail -n5 | grep -oP '(\d+\.){3}\d+' | while read IP ; do whois $IP | awk -F':' '/^Organization/ {print $2}' ; done

# Global variables
echo=`which echo`
netstat=`which netstat`
awk=`which awk`
sed=`which sed`

# Choosing connection type
echo "Please type PID or Program name"
read -p "Please enter a PID or Program name:" type
echo " You have entered $type"

IP=$(sudo netstat -tunapl | awk '/'$type'/ {print $5}' | cut -d: -f1 | sort | uniq -c | sort | tail -n5 | grep -oP '(\d+\.){3}\d+' | while read IP ; do whois $IP | awk -F':' '/^Organization/ {print $2}' ; done)
echo $IP
