#!/bin/bash

ACCOUNT="8205793100"    # bank account number
OUTPUTDIR="./data"

if [ -z "$1" ]
then
  echo "Fetch one month of transactions via HBCI from account $ACCOUNT"
  echo "Usage: `basename $0` YYYYMM"
  exit $E_NOARGS
fi

YYMONTH=$1
DATE_FROM="$YYMONTH"01
DATE_TO="$YYMONTH"31      # very simple heuristic, fortunately aqbanking and the bank swallow it
OUTPUTFILE="$OUTPUTDIR/transactions-$YYMONTH"

aqbanking-cli request --transactions -c $OUTPUTFILE.ctx -a $ACCOUNT --fromdate=$DATE_FROM --todate=$DATE_TO
mkdir -p $OUTPUTDIR
aqbanking-cli listtrans -c $OUTPUTFILE.ctx --exporter=csv --profile=full -o $OUTPUTFILE.csv
