jobs | grep checkLedgerChange.sh > /dev/null 2>&1
if [ $? -eq 0 ]; then
    rm -f ~/tmp/checkLedgerChange.pid
fi

jobs | grep checkTaskChange.sh > /dev/null 2>&1
if [ $? -eq 0 ]; then
    rm -f ~/tmp/checkTaskChange.pid
fi
