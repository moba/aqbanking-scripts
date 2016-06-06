#!/bin/sh
USER=VRK000xxxxxxx
BLZ=43060967
ACCOUNTNAME="openlab"

aqhbci-tool4 adduser -N $ACCOUNTNAME -u $USER -b $BLZ -s https://hbci-pintan.gad.de/cgi-bin/hbciservlet -t pintan --hbciversion=300
aqhbci-tool4 getsysid
aqbanking-cli request --balance
