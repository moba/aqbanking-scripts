# bank-transaction-stats.py

This is a script that we use to generate statistics over monthly CSVs exported from a bank account at a German GLS bank via HBCI (aqbanking).

## setup.py

You need this once to initialize aqbanking. It requires manual editing where you at least edit USER to contain your user account name at GLS (VRK000....).

Aqbanking stores its data in ~/.aqbanking.

## fetch.sh

This fetches data via HBCI using aqbanking and puts it into `data/`. It needs to know which month you're interested in and does not do any sophisticated checking whatsoever.

    ./fetch.sh 201604

=> produces `data/transactions-201604.csv` and `data/transactions-201604.ctx` (aqbanking db)

## stats.py

```
❯ ./stats.py data/transactions-201604.csv         ✚ ✭
-1969.84   | 1   |     
-1400.0    | 1   |
-1000.0    | 1   |
-232.0     | 1   |
-17.49     | 1   |
-2.0       | 1   |
5.0        | 2   |
6.68       | 1   |
10.0       | 25  |
15.0       | 3   |
20.0       | 1   |
23.42      | 1   |
30.0       | 22  |
50.0       | 3   |
70.0       | 1   |
120.0      | 1   |
600.0      | 1   |
1969.84    | 1   |

Total: -696.39

❯ ./stats.py data/transactions-201605.csv         ✚ ✭
-1400.0    | 1   |
-232.0     | 1   |
-2.0       | 1   |
5.0        | 3   |
10.0       | 27  |
15.0       | 3   |
20.0       | 1   |
23.42      | 1   |
30.0       | 22  |
50.0       | 4   |
70.0       | 1   |
119.71     | 1   |
350.0      | 1   |

Total: 139.13

```

## Licensed under CC0

Do whatever you want with it.

https://creativecommons.org/publicdomain/zero/1.0/legalcode
