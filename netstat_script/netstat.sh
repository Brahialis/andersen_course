#!/usr/bin/env bash

set -exuo pipefail

# sudo netstat -tunapl | awk '/firefox/ {print $5}' | cut -d: -f1 | sort | uniq -c | sort | tail -n5 | grep -oP '(\d+\.){3}\d+' | while read IP ; do whois $IP | awk -F':' '/^Organization/ {print $2}' ; done

# Global variables
echo=`which echo`
netstat=`which netstat`
awk=`which awk`
sed=`which sed`
whois=`which whois`
id=`which id`

# Check if user has root priveleges.
if  [[ $(id -u) != 0 ]]; then
    echo "Be aware: this script is running netstat and requires to run it as sudo to be able to run it properly."
    echo "Please run this script with sudo to get its full functionality."
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

# Choosing a PID or a Program name
read -p "Please specify a PID or a Program name you would like to see in the output (Default is [ALL])" pid_name
echo $pid_name

# Choosing a connection type
echo "Please enter a number (from 1 to 6) with the required connection type: "
select le in "LISTEN" "ESTABLISHED" "TIME_WAIT" "CLOSE_WAIT" "CLOSED" "ALL"; do
    case $le in
        LISTEN) 
          conn="LISTEN"
	  echo "You have chosen to display only ${conn} connections."
          ;;
        ESTABLISHED) 
          conn="ESTABLISHED"
	  echo "You have chosen to display only ${conn} connections."
          ;;
        TIME_WAIT)
	  conn="TIME_WAIT"
 	  echo "You have chosen to display only ${conn} connections."
	  ;;
	CLOSE_WAIT)
	  conn="CLOSE_WAIT"
  	  echo "You have chosen to display only ${conn} connections."
	  ;;
	CLOSED)
	  conn="CLOSED"
	  echo "You have chosen to display only ${conn} connections."
	  ;;
	ALL)
          conn=''
	  echo "You have chosen to display ALL connections."
	  ;; 
    esac
break
done


# Choosing a number of lines in the output 
read -p "Please specify a number of lines you would like to see in the output (Default is [5] lines): " lines
# Default value for lines
lines=${lines:-5}
echo "You have choosen to display $lines line(s) in the output."


#IP=$(netstat -tunapl | awk -v pid_name="$pid_name" -v conn="$conn" '$0~pid_name && $0~conn {print $5}' | cut -d: -f1 )

IP=$(netstat -tunapl | awk -v pid_name="$pid_name" -v conn="$conn" '$0~pid_name && $0~conn {print $5}' | cut -d: -f1 | sort | uniq -c | sort | tail -n ${lines})
echo "$IP"


