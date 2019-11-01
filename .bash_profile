
# Set command line editing to vi-style
set -o vi

# Setting environment variables
export PS1="[\h:\w]$ "
export CLICOLOR="true"
export LSCOLORS="gxfxcxdxbxegedabagaced"
export PATH=$HOME/bin:/usr/local/opt/gnu-getopt/bin:$PATH
export EDITOR=/usr/local/bin/vim
export BC_ENV_ARGS="-l $HOME/.bcrc"
export BROWSER=w3m
export PRJ=~/bin
export R_HOME=$(R RHOME)
export PHPRC=/usr/local/etc/php/7.1/php.ini
export SSID=$(networksetup -getairportnetwork en0 | cut -c 24-)
export FLAGS_GETOPT_CMD="$(brew --prefix gnu-getopt)/bin/getopt"

# Source other settings
if [ -f ~/.bashrc ]; then
    source ~/.bashrc;
fi
if [ -f ~/.googler ]; then
    source ~/.googler;         # aliases for command line google search
fi
if [ -f ~/.taskwarrior.sh ]; then
    source ~/.taskwarrior.sh;  # aliases for task routines
fi
if [ -f ~/.jrnl.sh ]; then
    source ~/.jrnl.sh;         # aliases for jrnl routines
fi
if [ -f ~/.gitalias ]; then
    source ~/.gitalias         # aliases for git routines
fi
if [ -f ~/.ledger.sh ]; then
    source ~/.ledger.sh;       # aliases for ledger routines
fi
if [ -f ~/.tmux_init.sh ]; then
    source ~/.tmux_init.sh;    # aliases for tmux operations
fi
if [ -f ~/.biblerc ]; then
    source ~/.biblerc;         # aliases for bible study
fi


# Aliases for PHP programming
alias class="grep -n -w --color=auto -e 'class' -e 'protected' -e 'public' -e 'const ' -e 'namespace' -e 'use'"
alias phpSnippets="vi ~/.vim_runtime/sources_non_forked/vim-snippets/snippets/php.snippets"
alias mySnippets="vi ~/.vim_runtime/snippets/_.snippets"

# Aliases to manage various servers on this machine
# alias httpdconf="ll /etc/apache2/httpd.conf"
alias httpdconf="more /usr/local/etc/apache2/2.4/httpd.conf"
# alias httpdvhosts="ll /etc/apache2/extra/httpd-vhosts.conf"
alias httpdvhosts="more /usr/local/etc/apache2/2.4/extra/httpd-vhosts.conf"
alias httpdrestart="sudo brew services restart httpd24"
alias httpdstart="sudo brew services start httpd24"
alias httpdstop="sudo brew services stop httpd24"
alias httpdlog="ls -al /usr/local/var/log/apache2/"
alias phpconf="more /usr/local/etc/php/7.1/php.ini"
# alias mysqlstop="sudo launchctl unload -F /Library/LaunchDaemons/com.oracle.oss.mysql.mysqld.plist"
# alias mysqlstart="sudo launchctl load -F /Library/LaunchDaemons/com.oracle.oss.mysql.mysqld.plist"
# alias mysqlconf="ll /Library/LaunchDaemons/com.oracle.oss.mysql.mysqld.plist"
alias mysqlhome="/usr/local/Cellar/mysql/5.7.17/"
alias mysqlstop="brew services stop mysql"
alias mysqlstart="brew services start mysql"
alias mysqlinit="more ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist"
alias mysqlconf="more /etc/my.cnf"
alias mysqldata="ls -al /usr/local/var/mysql"
alias Rconf="more $R_HOME/etc/Renviron"
alias Rinit="more ~/.Rprofile"

# Real quick shortcut to frequently used items
alias budget="budget"
alias mail="mutt"
alias wealth="w3m https://www.wealth.com.tw"
# alias RPi="ssh pi@180.176.111.91"
alias moneyline="open 'https://www.youtube.com/results?sp=CAISBAgCEAE%253D&search_query=%E9%8C%A2%E7%B7%9A%E7%99%BE%E5%88%86%E7%99%BE'"

alias macStorage="system_profiler SPStorageDataType | tail -n 19 | head -n 4"

function today () {
    datestring=$(date +'\033[31;107m%A, %B%e日, %Y年, %p%l:%M:%S\033[39;49m')
    echo -e "$datestring"
    ampm=$(date "+%p")
    if [ "$ampm" == "上午" ]
    then
        curl -sH "Accept-Language: ${LANG%_*}" wttr.in/"${1:-Taipei}"?1n | head -n 18
        echo -e "\033[31;107mCash Balance:\033[39;49m"
        ledger -f $LEDGER balance -R Expenses:Cash "Assets:Bank:SCSB Saving" "BOT Saving" -e $(date -v+1d "+%Y-%m-%d")
        echo ""
        echo -e "\033[31;107mUS Stocks:\033[39;49m"
        stock us
        echo ""
        review
    else
        curl -sH "Accept-Language: ${LANG%_*}" wttr.in/"${1:-Taipei}"?3n | tail -n 33 | head -n 30
        read -p "Press any key to continue..." -n 1
        echo ""
        echo -e "\033[31;107mMemorables:\033[39;49m"
        Today --short
        echo ""
        echo -e "\033[31;107mSpent Today:\033[39;49m"
        ledger -f $LEDGER register -b today -e tomorrow -R ^Expenses and not Expenses:Cash
        echo ""
        echo -e "\033[31;107mTaiwan Stocks:\033[39;49m"
        stock tw
        echo ""
        tasks
    fi
}

function wiki () {
    if [ -z $1 ]
    then
        vi ~/prj/MacBookPro/index.wiki
    else
        vi "~/prj/MacBookPro/$1.wiki"
    fi
}

function text2voice () {
    textfile="$1"
    if [ -z $2 ]
    then
        voicefile=$textfile
    else
        voicefile="$2"
    fi
    say -f "$textfile".txt --file-format=mp4f -o "$voicefile".mp4
}

# Get stock quotes from Yahoo! Finance
# API specs reference to: http://www.jarloo.com/yahoo_finance/
# csvfix is called to handle csv file. 
#     http://csvfix.byethost5.com/csvfix15/csvfix.html?i=1
function stock () {

    # Dow Jones Index (^dji) and SENSEX (^bsesn) currently return N/A
    market="$1"
    case "$market" in
    "tw")
        stocks="^TWII 2059.TW 2888.TW 3481.TW 4906.TW 5264.TW 5434.TW 6206.TW 6277.TW 8114.TW"
        ;;
    "us")
        stocks="^DJI ^IXIC AAPL GOOG FB AMZN MSFT NVDA CR"
        ;;
    "index")
        stocks="^DJI ^IXIC ^SOX ^VIX BZ=F ^TNX DX-Y.NYB ^TWII ^BSESN"
        ;;
    "commod")
        stocks="^HUI GC=F CL=F"
        ;;
    "currency")
        stocks="USDTWD=X USDCNY=X USDJPY=X USDEUR=X"
        ;;
    "crypto")
        stocks="BTCUSD=X ETHUSD=X"
        ;;
    "fund")
        stocks="TW000T3615Y9.TW"
        ;;
    *)
        stocks="^DJI ^TWII AAPL GOOG FB 5434.TW 2330.TW USDTWD=X"
        ;;
    esac

    ~/bin/ticker.sh ${stocks}

#    url="http://download.finance.yahoo.com/d/quotes.csv?s=$stocks&f=nl1c1p2xm3m4"
#    curl -s "${url}" > ~/tmp/stockquote.txt

#    echo "                         Quote    Price    Delta  Delta %    50 MA   200 MA"
#    echo "============================== ======== ======== ======== ======== ========"
#    csvfix printf -fmt "%30s %8s %8s %8s %8s %8s" -f 1,2,3,4,6,7 ~/tmp/stockquote.txt
    
#    rm ~/tmp/stockquote.txt

}

function g () {
    pushd ~/tmp
    $(which googler) -n 5 --lang zh-TW "$@"
    popd
}

function sam () {
    grep "撒母耳記上 $1:" ~/doc/和合本聖經.txt | awk '{print $3" "$4"//"$5}' | more
}

function countdown () {                 # Countdown timer, $1 in seconds
    if [ -z "$1" ]
    then
        countTime=60
    else
        countTime=$1
    fi
    date1=$((`date +%s` + $countTime))
    while [ "$date1" -ge `date +%s` ]
    do
        echo -ne "Timer: $(date -ju -f %s $(($date1 - `date +%s` )) +%H:%M:%S)\r";
        sleep 0.1
    done
    echo
    echo -e "\033[31;107mTIME IS UP!\033[39;49m";
    echo "Time is up" | say -v Alex
}

function stopwatch () {
    date1=`date +%s`
    while true
    do
        # echo -ne "$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r"
        echo -ne "Elapsed Time: $(date -ju -f %s $((`date +%s` - $date1)) +%H:%M:%S)\r"
        sleep 0.1
    done
    echo
}

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
