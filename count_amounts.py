#!/usr/bin/env python
# account-stats.py
#  reads a CSV file from bank and prints out some statistics
#  of the transactions
#
# aqbanking csv export format
##
#  hacked together by Moritz Bartl
#  licensed under MIT

from __future__ import print_function
import csv
import os.path
import calendar
from datetime    import date,        datetime
from collections import OrderedDict, Counter
from sys         import argv
import sys

DATE_FIELD = "date"
DATE_FORMAT = "%Y/%m/%d"
AMOUNT_FIELD = "value_value"
PURPOSE_FIELD= "purpose"

###########################################################

def usage():
    print(argv[0] + ' [table|tsv] transactions.csv')
    exit(2)

# parse command line
try:
    mode = argv[1]
    csv_filename = argv[2]
    csvfile = open(csv_filename, 'r')
except:
    usage()

if not mode in ["table", "tsv"]:
    usage()

# prepare counter for amounts
amount_counter = Counter();

# Read-in csv file and count amounts
reader = csv.DictReader(csvfile, delimiter=';')
month = ""
year = ""
for row in reader:
    amount = float(row[AMOUNT_FIELD].replace('/100',''))/100
    amount_counter[amount] += 1
    month = datetime.strptime(row[DATE_FIELD], DATE_FORMAT).date().month
    year = datetime.strptime(row[DATE_FIELD], DATE_FORMAT).date().year
    ## only amount used here; rest for demonstration purposes
    #    date = datetime.strptime(row[DATE_FIELD], DATE_FORMAT).date()
    #    purpose = row[PURPOSE_FIELD]

# sort the counter-entries by amount
amount_counter = OrderedDict(sorted(amount_counter.items()))

# Print all amounts and their count
# (And sum up total balance during this)
total = 0
income = 0
expenses = 0

amountcount = []
for amount in amount_counter:
    count     = amount_counter[amount]
    ascii_bar = " " + count * "#"
    value     = count * amount
    total     = total + value
    if value > 0:
        income = income + value
    else:
        expenses = expenses - value
    amountcount.append((amount, count))

if mode == "table":
    for (amount, count) in amountcount:
        print("{:<10} | {:<3} |".format(amount , count) + ascii_bar)
    # Print total balance of this csv file
    print("Income:   " + str(income))
    print("Expenses: " + str(expenses))
    print("Total:    " + str(total))

elif mode == "tsv":
    writer = csv.writer(sys.stdout, delimiter='\t')
    writer.writerow(['type', 'year', 'month', 'value', 'color'])
    writer.writerow(['Ausgaben', year, calendar.month_name[month], str(expenses), 'red'])
    writer.writerow(['Einnahmen', year, calendar.month_name[month], str(income), 'green'])

else:
    print("this should not be reached", file=sys.stderr)
    exit(2)
