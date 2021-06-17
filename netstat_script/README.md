# ***Netstat Script

This script uses netstat and whois utilities to get info about connections:
+ IP addresses and organizations they belong to
+ Number of connections

The script interracts with user allowing to input the following parameters:
+ Pid or Program name
+ Connection type: [ "LISTEN" "ESTABLISHED" "TIME_WAIT" "CLOSE_WAIT" "CLOSED" "ALL" ]
+ Number of lines in the output [ default is 5 lines]

Be aware: this script is using netstat and requires to run it with root privileges.
Also netstat and whois utilities should be installed to be able to run this script.



