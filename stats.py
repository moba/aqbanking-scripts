#!/usr/bin/python
# account-stats.py
#  reads a CSV file from bank and prints out some statistics
#  of the transactions
#
# aqbanking csv export format
##
#  hacked together by Moritz Bartl
#  licensed under MIT

import csv
from datetime import date, datetime
from collections import OrderedDict
from sys import argv

DATE_FIELD = "date"
DATE_FORMAT = "%Y/%m/%d"
AMOUNT_FIELD = "value_value"
PURPOSE_FIELD= "purpose"

###########################################################

# parse command line
try:
    csv_filename = argv[1]
    csvfile = open(csv_filename, 'rb')
except:
    print argv[0] + ' transactions.csv'
    exit(2)

# prepare dictionary for transactions
class TransactionsCounter(dict):
    def __missing__(self, key):
        return 0
transactions = TransactionsCounter()

reader = csv.DictReader(csvfile, delimiter=';')
for row in reader:
    amount = float(row[AMOUNT_FIELD].replace('/100',''))/100

## only amount used here; rest for demonstration purposes
#    date = datetime.strptime(row[DATE_FIELD], DATE_FORMAT).date()
#    purpose = row[PURPOSE_FIELD]

    transactions[amount] = transactions[amount]+1

transactions = OrderedDict(sorted(transactions.items())) # sort chronologically

total = 0
for amount in transactions:
    count = transactions[amount]
    total = total + (count * amount)
    print "{:<10} | {:<3} |".format(amount , count)

print ""
print "Total: " + str(total)
