
export LEDGERPATH=~/prj/MacBookPro/ledger
export LEDGER=$LEDGERPATH/Chien-pinWang.ledger
export ACCOUNTS=$LEDGERPATH/accounts.dat

alias trx="vTab $LEDGER $ACCOUNTS ~/.ledger.sh ~/prj/MacBookPro/ledger.wiki"

# checkLedgerChange checks if the ledger file has been changed. Once a change
# is detected, several real-time status reports, such as the cash report, are
# updated accordingly. I can check them on the go at mobile phone.
# This function should be invoked and executed at the background.
function checkLedgerChange () {
    # m1=$(md5 -q ~/prj/MacBookPro/ledger/Chien-pinWang.ledger)
    m1=$(/sbin/md5 -q "$LEDGER")

    while true
    do
        sleep 60
        m2=$(/sbin/md5 -q "$LEDGER")
        if [ "$m1" != "$m2" ]
        then
            periodE=$(date -v+1d +"%Y-%m-%d")

            cash > "$LEDGERPATH"/reports/cash.txt
            tscb > "$LEDGERPATH"/reports/tscb.txt
            scsb > "$LEDGERPATH"/reports/scsb.txt
            budget > "$LEDGERPATH"/reports/budget.txt
            
            m1="$m2"
        fi
    done
}

# balancesheet displays the balance of Assets and Liabilities accounts at
# a given date, default to today. The cost of commodities (-B) is used in the
# report.
# Command syntax:
#   balancesheet [as_of_date]
function balancesheet () {
    if [ -z "$1" ]
    then
        periodRange=$(_getPeriodBeginEnd today)
        periodB=${periodRange:0:10}
        periodE=${periodRange:11}
    else
        periodE=$(date -j -f %Y-%m-%d -v+1d "$1" +%Y-%m-%d)
    fi
    echo "BALANCE SHEET (as of $periodE)"
    ledger -f "$LEDGER" balance -B ^Assets ^Liabilities --depth 3 -e "$periodE"
    
}

# incomestatement displays the income and expenses of a given date range,
# default to the last month. The cost of commodities (-B) is used in the
# report.
# Command syntax:
#   incomestatement [begin_date] [end_date]
function incomestatement () {
    if [ -z "$1" ]
    then
        periodRange=$(_getPeriodBeginEnd lastmonth)
        periodB=${periodRange:0:10}
        periodE=${periodRange:11}
    else
        periodB="$1"
        periodE="$2"
    fi

    echo "INCOME STATEMENT ($periodB to $periodE)"
    ledger -f "$LEDGER" balance ^Income ^Expenses and not Expenses:Cash -b "$periodB" -e "$periodE" --depth 2
}

# cash displays the current balance of two cash accounts:
#   Assets:Bank:SCSB Saving
#   Expenses:Cash
# Command Syntax:
#   cash
function cash () {
    periodE=$(date -v+1d +"%Y-%m-%d")

    echo "CASH BALANCE"
    ledger -f "$LEDGER" balance -R "SCSB Saving" Expenses:Cash -e $periodE
}

# _getPeriodBeginEnd returns a pair of space seperated dates representing the
# beginning and ending dates of a request period symbol. Symbols can be the
# following:
#       week, wtd, lastweek, month, mtd, lastmonth, today (default)
#
# The calling function should use the $(_getPeriodBeginEnd [symbol]) to obtain
# the dates and sub-string to seperate them into variables.
#
# This is a private function not intended to be called directly by users.
function _getPeriodBeginEnd() {
    period=$1
    case $period in
    "week")             # Last 7 days
        periodBegin=$(date -v-7d +%Y-%m-%d)
        periodEnd=$(date -v+1d +%Y-%m-%d)
        ;;
    "wtd")              # Week to date
        periodBegin=$(date -vsunday +%Y-%m-%d)
        periodEnd=$(date -v+1d +%Y-%m-%d)
        ;;
    "lastweek")         # Last week
        periodBegin=$(date -v-7d -vsunday +%Y-%m-%d)
        periodEnd=$(date -v-7d -vsaturday -v+1d +%Y-%m-%d)
        ;;
    "month")            # Last 30 days
        periodBegin=$(date -v-30d +%Y-%m-%d)
        periodEnd=$(date -v+1d +%Y-%m-%d)
        ;;
    "mtd")              # Month to date
        periodBegin=$(date +%Y-%m-01)
        periodEnd=$(date -v+1d +%Y-%m-%d)
        ;;
    "lastmonth")        # Last month
        periodBegin=$(date -v-1m -v1d +%Y-%m-%d)
        periodEnd=$(date -v1d +%Y-%m-%d)
        ;;
    *)                  # Today
        periodBegin=$(date +%Y-%m-%d)
        periodEnd=$(date -v+1d +%Y-%m-%d)
        ;;
    esac

    echo "$periodBegin $periodEnd"
}

function scsb () {
    periodRange=$(_getPeriodBeginEnd "$1")
    periodB=${periodRange:0:10}
    periodE=${periodRange:11}
    ledger -f "$LEDGER" register "Liabilities:Card:SCSB One Card" -U --no-pager
}

function tscb () {
    periodRange=$(_getPeriodBeginEnd "$1")
    periodB=${periodRange:0:10}
    periodE=${periodRange:11}
    ledger -f "$LEDGER" register "Liabilities:Card:TSCB Visa" -U --no-pager
}

# spent shows the balance and history of spendings during a period of time.
# When none of the arguments is present, spent shows all accounts month-to-
# date records.
#   Command Syntax:
#       spent [period] [account]
function spent () {
    if [ -z "$1" ]
    then
        period="mtd"
    else
        period="$1"
    fi

    if [ -z "$2" ]
    then
        account=""
    else
        account=":$2"
    fi

    periodRange=$(_getPeriodBeginEnd "$period")
    periodB=${periodRange:0:10}
    periodE=${periodRange:11}
    # ledger -f "$LEDGER" balance -R Expenses and not \(Expenses:Cash or ^Budget:Expenses\) --depth 2 -b "$periodB" -e "$periodE"
    ledger -f "$LEDGER" balance -R ^Expenses"$account" and not Expenses:Cash --depth 2 -b "$periodB" -e "$periodE"
    read -p "Press any key to continue..." -n 1
    # ledger -f "$LEDGER" register -R Expenses and not \(Expenses:Cash or ^Budget:Expenses\) -b "$periodB" -e "$periodE"
    ledger -f "$LEDGER" register -R ^Expenses"$account" and not Expenses:Cash -b "$periodB" -e "$periodE"
}

function debt () {
    periodRange=$(_getPeriodBeginEnd "$1")
    periodB=${periodRange:0:10}
    periodE=${periodRange:11}
    ledger -f "$LEDGER" balance ^Liabilities -b 2017-03-01 -e "$periodE"
}

function budget () {                       # Budget always run current mtd
    periodRange=$(_getPeriodBeginEnd mtd)
    periodB=${periodRange:0:10}
    periodE=${periodRange:11}

    OLDLANG=$LANG
    LANG="en_US.UTF-8"
    monthname=$(date +"%B")
    LANG=$OLDLANG

    if [ -z $1 ]
    then
        ledger -f "$LEDGER" register "expr" "payee =~ /$monthname Expenses Budget/" --no-pager
        ledger -f "$LEDGER" balance ^Budget:Expenses -b "$periodB" -e "$periodE"
    else
        ledger -f "$LEDGER" register Budget:Expenses:"$1" -b "$periodB" -e "$periodE"
    fi
}

function unbudget () {
    periodRange=$(_getPeriodBeginEnd mtd)
    periodB=${periodRange:0:10}
    periodE=${periodRange:11}
    ledger -f "$LEDGER" register tag\(unbudgeted\) -b "$periodB" -e "$periodE"
}

function payable () {
    ledger -f "$LEDGER" register -U Liabilities:Payable:Personal --no-pager
}

function receivable () {
    ledger -f "$LEDGER" register -U Assets:Receivable:Personal --no-pager
}

function payee () {
    echo "Pay History to $@ in the Past 90 Days:"
    periodB=$(date -v-90d +"%Y-%m-%d")
    periodE=$(date -v+1d +"%Y-%m-%d")
    ledger -f "$LEDGER" register -R ^Expenses and not Expenses:Cash and payee\("$@"\) -b "$periodB" -e "$periodE"
}

# The script is an adopted version from https://www.sundialdreams.com/report-scripts-for-ledger-cli-with-gnuplot/
# Here are what I changed:
#   0. At the LEDGER_TERM ine, use 'x11' instead of 'qt'
#   1. At the ledger command line, added '-R' to report real transactions
#   2. At the ledger command line, change -W to -D for daily total
#   3. At the gnuplot command line, set title to 'Daily $@'
#   4. At the gnuplot command line, plot xticlabels with strftime to '%b %d' for 'Month date', rather than just '%b' for 'Month'
#   5. At the gnuplot command line, plot font 'Courier,12' instead of 'Courier,8'

function dailyplot () {
    if [ -z "$LEDGER_TERM" ]; then
        # LEDGER_TERM="x11 size 1280,720 persist"
        LEDGER_TERM="x11 size 640,360 persist"
    fi

    periodRange=$(_getPeriodBeginEnd mtd)
    periodB=${periodRange:0:10}
    periodE=${periodRange:11}

    ledger -j -R reg "$@" -D -b "$periodB" -e "$periodE" --collapse --plot-amount-format="%(format_date(date, \"%Y-%m-%d\")) %(abs(quantity(scrub(display_amount))))\n" > ledgeroutput1.tmp

    (cat <<EOF) | gnuplot
        set terminal $LEDGER_TERM
        set style data histogram
        set style histogram clustered gap 1
        set style fill transparent solid 0.4 noborder
        set xtics nomirror scale 0 center
        set ytics add ('' 0) scale 0
        set border 1
        set grid ytics
        set title "Daily $@"
        set ylabel "Amount"
        plot "ledgeroutput1.tmp" using 2:xticlabels(strftime('%b %d', strptime('%Y-%m-%d', strcol(1)))) notitle linecolor rgb "light-turquoise", '' using 0:2:2 with labels font "Courier,12" offset 0,0.5 textcolor linestyle 0 notitle
EOF

    rm ledgeroutput*.tmp
}

function lTag () {
    periodRange=$(_getPeriodBeginEnd "$1")
    periodB=${periodRange:0:10}
    periodE=${periodRange:11}
    ledger -f "$LEDGER" register tag\("$2"\) -b "$periodB" -e "$periodE"
}

checkLedgerChange &
