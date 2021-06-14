#!/usr/bin/env bash

set -Eeuo pipefail

# Along with "set -E" option, allows to catch ERR traps which do not fire in certain scenarios (even with "set -e")
trap ERR_TRAP ERR

ERR_TRAP () {
       trap - ERR
       echo "Something went wrong. Error trap fired, please investigate it!"
}

# Global variables
echo=`which echo`
netstat=`which netstat`
awk=`which awk`
sed=`which sed`


