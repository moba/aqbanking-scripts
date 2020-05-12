#!/usr/bin/env bash

# PSD2: allowed to grab max 90 days without 2FA
DATE_FROM=$(date -d "-89 days" +%Y%m%d)

ACCOUNT="1126825606"    # testing with riseup account

PINFILE="$HOME/.aqbanking/pinfile"      # run script as separate user
DESTINATION="transactions.csv"

NEW_CTX=$(mktemp -t aqbanking-ctx.XXXXXXX)
NEW_CSV=$(mktemp -t aqbanking-csv.XXXXXXX)
MERGED=$(mktemp -t aqbanking-merge.XXXXXXX)

# trap: catch script exit and remove temporary files
trap 'shred -u "$NEW_CTX" "$NEW_CSV"' EXIT

# create empty DESTINATION if it doesn't exist
[ ! -f "$DESTINATION" ] && touch $DESTINATION

##### MAIN: FETCH, EXPORT TO CSV, MERGE USING DIFF

aqbanking-cli -n -P $PINFILE request --transactions -c $NEW_CTX -a $ACCOUNT --fromdate=$DATE_FROM
aqbanking-cli export -c $NEW_CTX --exporter=csv --profile=full -o $NEW_CSV

diff --line-format='%L' $DESTINATION $NEW_CSV > $MERGED

mv $DESTINATION $DESTINATION.$(date +%Y%m%d)
mv $MERGED $DESTINATION
