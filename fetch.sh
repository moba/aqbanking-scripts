#!/usr/bin/env bash
set -e -o pipefail

ACCOUNT="8205793100"    # bank account number
OUTPUTDIR="./data-openlab"

if [ -z "$1" ]
then
  echo "Fetch one month of transactions via HBCI from account $ACCOUNT"
  echo "Usage: `basename $0` YYYYMM"
  exit $E_NOARGS
fi

YYMONTH=$1
DATE_FROM="$YYMONTH"01
DATE_TO=$(date -d "$DATE_FROM +1 month -1 day" +%Y%m%d)
OUTPUTFILE="$OUTPUTDIR/transactions-$YYMONTH"

aqbanking-cli request --transactions -c $OUTPUTFILE.ctx -a $ACCOUNT --fromdate=$DATE_FROM --todate=$DATE_TO
mkdir -p $OUTPUTDIR
aqbanking-cli export -c $OUTPUTFILE.ctx --exporter=csv --profile=full -o $OUTPUTFILE.csv
