## setup.sh

*The setup script is currently broken. Every bank requires a custom setup.* 

 * https://www.aquamaniac.de/rdm/projects/aqbanking/wiki/AqBanking6_Bankentabelle
 * https://www.aquamaniac.de/rdm/projects/aqbanking/wiki/SetupPinTan

You need this once to initialize aqbanking. It requires manual editing where you at least edit USER to contain your user account name at GLS (VRK000....).

Aqbanking stores its data in ~/.aqbanking.

## update.sh

`update.sh` is work in progress to fetch updates and intelligently merge new transactions to a continuously complete CSV export. It is meant to be run periodically, e.g. via cron. At this point it is a demo, and you will likely  want to test it and customize to your own needs.

## fetch.sh

This fetches data via HBCI using aqbanking and puts it into `data/`. It needs to know which month you're interested in and does not do any sophisticated checking whatsoever.

    ./fetch.sh 201604

=> produces `data/transactions-201604.csv` and `data/transactions-201604.ctx` (aqbanking db)

## count_amounts.py

This should probably be moved to https://github.com/moba/bank-transaction-stats .

```
❯ ./count_amounts.py data/transactions-201604.csv         ✚ ✭
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

❯ ./count_amounts.py data/transactions-201605.csv         ✚ ✭
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

## list-spendings.jl

First, you need to install julia
```
apt install julia
```

Then you can run the script, the first run will take some time (~1 min)
because julia will compile several base libraries and install some dependencies.

I recommend running the script via `include()` in the interactive julia shell
because this way you get beautifull pretty-printing of the tables at the end.
This is done by:

```
$ julia
               _
   _       _ _(_)_     |  A fresh approach to technical computing
  (_)     | (_) (_)    |  Documentation: http://docs.julialang.org
   _ _   _| |_  __ _   |  Type "?help" for help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 0.4.5 (2016-03-18 00:58 UTC)
 _/ |\__'_|_|_|\__'_|  |  
|__/                   |  x86_64-linux-gnu


julia> include("list-spendings.jl")

2×3 DataFrames.DataFrame
│ Row │ purpose                                                                              │ remoteName      │ value_value │
├─────┼──────────────────────────────────────────────────────────────────────────────────────┼─────────────────┼─────────────┤
│ 1   │ "Abrechnung vom 29.04.2016"                                                          │ ""              │ -2.0        │
│ 2   │ "16 VK: 21422139323 gruenstrom easy60 PG24/16 VK: 2421912332 gruenstrom easy60 PG24" │ "Mahlzahn GmbH" │ -232.0      │

```

The disadvantage of the *"repl-include"* approach lies in the fact that it's not possible to supply cli-arguments via
the `include()` function. Therefore the name of the input-csv-file had to be hardcoded and is currently set to
```
demo.csv
```
Which means you have to name your input-csv-file `demo.csv` to get read by list-spendings.jl.

## Licensed under CC0

Do whatever you want with it.

https://creativecommons.org/publicdomain/zero/1.0/legalcode
