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
from datetime    import date,        datetime
from collections import OrderedDict, Counter
from sys         import argv

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

# prepare counter for amounts
amount_counter = Counter();

# Read-in csv file and count amounts
reader = csv.DictReader(csvfile, delimiter=';')
for row in reader:
    amount = float(row[AMOUNT_FIELD].replace('/100',''))/100
    amount_counter[amount] += 1
    ## only amount used here; rest for demonstration purposes
    #    date = datetime.strptime(row[DATE_FIELD], DATE_FORMAT).date()
    #    purpose = row[PURPOSE_FIELD]

# sort the counter-entries by amount
amount_counter = OrderedDict(sorted(amount_counter.items()))

# Print all amounts and their count
# (And sum up total balance during this)
total = 0
for amount in amount_counter:
    count = amount_counter[amount]
    total = total + (count * amount)

    print "{:<10} | {:<3} |".format(amount , count)

# Print total balance of this csv file
print "\nTotal: " + str(total)
