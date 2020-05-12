#!/bin/sh

## TODO: NEEDS FIXING; does not work that way any more. check aqbanking notes

set -e
USER=VRK1495266731666348
BLZ=43060967
ACCOUNTNAME="openlab"

aqhbci-tool4 adduser -N $ACCOUNTNAME -u $USER -b $BLZ -s https://hbci-pintan.gad.de/cgi-bin/hbciservlet -t pintan --hbciversion=300
aqhbci-tool4 getsysid --user="$USER" --customer="$USER"
aqbanking-cli request --bank="$BLZ" --balance
