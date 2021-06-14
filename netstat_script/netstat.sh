#!/usr/bin/env bash

set -exuo pipefail

# sudo netstat -tunapl | awk '/firefox/ {print $5}' | cut -d: -f1 | sort | uniq -c | sort | tail -n5 | grep -oP '(\d+\.){3}\d+' | while read IP ; do whois $IP | awk -F':' '/^Organization/ {print $2}' ; done

# Global variables
echo=`which echo`
netstat=`which netstat`
awk=`which awk`
sed=`which sed`
whois=`which whois`

# Check if user has root priveleges.
if  [[ $(id -u) != 0 ]]; then
    echo "Be aware: this script is running netstat and requires to run it as sudo to be able to run it properly."
    echo "Please run this script with sudo"
    echo "Terminating and exiting...."
    exit 1
fi

# Checking if needed programs are installed
if [[ -z $netstat ]]; then
    echo "Could not find netstat utility, please install it first!"
    echo "Terminating and exiting...."
    exit 1
fi

if [[ -z $whois ]]; then
    echo "Could not find whois utility, please install it first!"
    echo "Terminating and exiting...."
    exit 1
fi

# Choosing connection type

echo "Please type PID or Program name"
read -p "Please enter a PID or Program name:" pid_name
echo " You have entered $pid_name"

#IP=$(netstat -tunapl | awk '/'$type'/ {print $5}' | cut -d: -f1 | sort | uniq -c | sort | tail -n5 | grep -oP '(\d+\.){3}\d+' | while read IP ; do whois $IP | awk -F':' '/^Organization/ {print $2}' ; done)
# This script is running netstat and requires to run it as sudo to be able to run it properly

