# aqbanking notes

    apt-get install aqbanking-tools

https://wiki.gnucash.org/wiki/De/Flatpak/Migrationsanleitung
https://www.aquamaniac.de/rdm/projects/aqbanking/wiki/SetupPinTan#best-practice

# dedicated user (important for pinfile)

If you want to fetch transactions automatically, you create a `pinfile` that contains your PIN. It is highly recommended to create a separate user to shield this PIN from anything running under your regular account.

    sudo adduser --disabled-password aqbanking
    sudo su aqbanking
    cd ~

# GLS

    USERID=VRK000xxxxxxx (login name)
    CUSTOMERID=often account number
    BLZ=43060967
    aqhbci-tool4 adduser -h
    aqhbci-tool4 adduser -N $USERNAME -u $USERID -b $BLZ -c $CUSTOMERID -s https://hbci-pintan.gad.de/cgi-bin/hbciservlet -t pintan --hbciversion=300
    aqhbci-tool4 listusers # UID= Unique Id
    aqhbci-tool4 getsysid -u $UID
    aqhbci-tool4 getitanmodes -u $UID
    aqhbci-tool4 setitanmode -u $UID -m 6942     # 6942: MTAN2 at the time of writing
    aqhbci-tool4 getaccounts -u $UID
    aqhbci-tool4 listaccounts -v # $ACCOUNTID = LocalUniqueId
    aqhbci-tool4 getaccsepa -a $ACCOUNTID # for each account

    aqhbci-tool4 mkpinlist > ~/.aqbanking/pinfile
    chmod 400 ~/.aqbanking/pinfile
    # edit the file and add your PIN(s)

    aqbanking-cli request --balance -a $ACCOUTNUMBER

    aqbanking-cli -n -P ~/.aqbanking/pinfile request --transactions -c transactions.ctx   # get PIN from file
    aqbanking-cli request --transactions -c transactions.ctx --fromdate=20100101 --todate=20130101 -a $ACCOUNTNR
    aqbanking-cli export -c transactions.ctx --exporter=csv --profile=full -o transactions.csv

# DKB (untested!)

    aqhbci-tool4 adduser  \
        -s https://banking-dkb.s-fints-pt-dkb.de/fints30 \
        -b 12030000 -u 1532512_c -N 1532512_c -c 1532512_c \
        --hbciversion=300 -t pintan
