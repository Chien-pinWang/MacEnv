
# Set command line editing to vi-style
set -o vi

# Setting environment variables
export PS1="[\h:\w]$ "
export CLICOLOR="true"
export LSCOLORS="gxfxcxdxbxegedabagaced"
export PATH=$HOME/bin:$PATH
export EDITOR=/usr/local/bin/vim
export PRJ=~/bin
export R_HOME=$(R RHOME)
export BC_ENV_ARGS="-l $HOME/.bcrc"
export BROWSER=w3m
export PHPRC=/usr/local/etc/php/7.1/php.ini
export SSID=$(networksetup -getairportnetwork en0 | cut -c 24-)

# Source other settings
source ~/.googler           # aliases for command line google search
source ~/.taskwarrior.sh    # aliases for task routines
source ~/.jrnl              # aliases for jrnl routines
source ~/.gitalias          # aliases for git routines
source ~/.ledger.sh         # aliases for ledger routines

# Aliases to execute commands
alias setSSID="export SSID=$(networksetup -getairportnetwork en0 | cut -c 24-)"
alias agrep="alias | grep "
alias v="/usr/local/bin/vim"
alias def="clear; /usr/local/bin/dict"
alias vSplit="vi -O"
alias vStack="vi -o"
alias vTab="vi -p"
alias cp="cp -iv"
alias mv="mv -iv"
alias ls="ls -FGhp"
alias ll="ls -FGlAhp"
alias less="less -FSRXc"
alias cls="clear"
alias src="source ~/.bash_profile"
alias now="date +'%T'"
alias psg="ps aux | grep --color=auto"
# alias path="echo -e ${PATH//:/\\n}"
alias calc="bc -q"
alias sheet="sc"
alias slide="mdp"
alias waves="php ~/bin/Buoy/index.php"
alias t="task ls"
alias cron="crontab -e"
alias tree="tree -d | more"
alias phpweb="php -S 127.0.0.1:8080 &"
alias w="pushd ~/tmp; w3m -B; popd"
alias notify="vi ~/bin/OSNotification.sh; crontab -e"
# alias g="pushd ~/tmp; $(which googler) -n 5 --lang zh-TW -t y1; popd"
# alias blockchain="$(which googler) -n 5 -N blockchain"
alias blockchain="vi ~/prj/blockchain/blockchain.txt +:tabedit +':W3m https://www.google.com.tw/search?q=blockchain&tbm=nws'"
alias cal="task calendar"
alias weather='curl -sH "Accept-Language: zh" wttr.in/Taipei?2n | head -n 28; w3m -dump -no-cookie http://cwb.gov.tw/V7/observe/24real/Data/46692.htm | head -n 10'
# alias truecrypt="/Applications/TrueCrypt.app/Contents/MacOS/TrueCrypt --text"
# alias pwd="/Applications/TrueCrypt.app/Contents/MacOS/TrueCrypt --text --password=SY42567F4 --mount ~/Dropbox/TrueCryptVolume /Volumes/TrueCrypt"
# alias xpwd="/Applications/TrueCrypt.app/Contents/MacOS/TrueCrypt --text --dismount /Volumes/TrueCrypt"

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

# Aliases to move around file systems
alias 2bin="cd ~/bin"
alias 2prj='cd $PRJ'     # Type "PRJ=<path/to/prj/root>" at command line to reset active project
alias tmp="pushd ~/tmp"
alias ..="cd .."
alias ...="cd ../.."
alias ~="cd ~"

# Real quick shortcut to frequently used items
alias budget="budget"
alias bill="tBill"
alias tasks="tActive"
alias next="task mynext"
alias later="task schedule.after:today+1y mylist"
alias weekload="echo -e '\033[31;107mUPCOMING IN A WEEK:\033[39;49m'; task rc.dateformat:'a m/d' weekload"
alias review="tReview"
alias due="tWeek"
alias overdue="tOverdue"
alias checkoff="tCheck"
alias pushback="tPush"
alias mail="mutt"

alias macStorage="system_profiler SPStorageDataType | head -n 6"

# Bash function helpers
cd() { builtin cd "$@"; ls; }               # cd then ls;
trash() { command mv "$@" ~/.Trash ; }      # move to ~/.Trash folder
ff() { /usr/bin/find . -name "$@" ; }       # find files match name in arg 1
function v? () {
    while read line
    do
        echo -e "$line"
    done < ~/.vim/vHint.txt
}

function putBuf () {
    echo "$@" >> ~/tmp/wip.buf
}

function getBuf () {
    if [ -f ~/tmp/wip.buf ]
    then
        echo -e "\033[31;107mTHERE ARE WORK-IN-PROGRESS...\033[39;49m"
        # cat ~/tmp/wip.buf
        lineno=1
        while read line
        do
            area=$(cut -d ' ' -f 1 <<< "$line")
            if [ "$area" != "HOME" -o "$SSID" != "VW4Fstaff" ]
            then
                echo "$lineno $line"
                lineno=$(bc <<< "$lineno+1")
            fi
        done < ~/tmp/wip.buf
    else
        echo -e "\033[31;107mThere is no work-in-progress.\033[39;49m"
    fi
}

function rmBuf () {
    if [ -z $1 ]
    then
        echo "Usage: rmBuf [ID]"
        return 1
    else
        lineno=1
        while read line
        do
            if [ "$lineno" != "$1" ]
            then
                echo "$line" >> ~/tmp/wip.buf.tmp
            else
                echo "Buffer [$line] is removed."
            fi
            lineno=$(bc <<< "$lineno+1")
        done < ~/tmp/wip.buf
        mv ~/tmp/wip.buf.tmp ~/tmp/wip.buf
    fi
}

function today () {
    datestring=$(date +'\033[31;107m%A, %B%e日, %Y年, %p%l:%M:%S\033[39;49m')
    echo -e "$datestring"
    ampm=$(date "+%p")
    if [ "$ampm" == "上午" ]
    then
        curl -sH "Accept-Language: ${LANG%_*}" wttr.in/"${1:-Taipei}"?1n | head -n 18
        echo -e "\033[31;107mCash Balance:\033[39;49m"
        ledger -f $LEDGER balance -R Expenses:Cash "Assets:Bank:SCSB Saving" -e $(date -v+1d "+%Y-%m-%d")
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
        jToday --short
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

function journal () {
    j="$1"
    case "$j" in
    "goofy")
        template="goofy_template.txt"
        ;;
    "blockchain")
        template="blockchain_template.txt"
        ;;
    "here")
        template="default_template.txt"
        ;;
    *)
        template="default_template.txt"
        j=""
        ;;
    esac
    jrnl $j < ~/prj/MacBookPro/.jrnl/"$template"
    jrnl $1 -1 --edit
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
        stocks="^twii,5434.tw,2330.tw,3008.tw,2049.tw"
        ;;
    "us")
        stocks="^ixic,aapl,goog,fb,amzn,msft,cr,nvda"
        ;;
    "index")
        stocks="^dji,^ixic,^vix,^twii"
        ;;
    "commod")
        stocks="^hui,gc=f,cl=f"
        ;;
    "currency")
        stocks="usdtwd=x,usdcny=x,usdjpy=x,usdeur=x"
        ;;
    "crypto")
        echo "Bitcoin: \$$(curl -s https://coinmarketcap-nexuist.rhcloud.com/api/btc | jq '.price.usd')"
        echo "Ether: \$$(curl -s https://coinmarketcap-nexuist.rhcloud.com/api/eth | jq '.price.usd')"
        ;;
    *)
        stocks="^ixic,^vix,^twii,aapl,goog,fb,usdtwd=x"
        ;;
    esac

    url="http://download.finance.yahoo.com/d/quotes.csv?s=$stocks&f=nl1c1p2xm3m4"
    curl -s "${url}" > ~/tmp/stockquote.txt

    echo "                         Quote    Price    Delta  Delta %    50 MA   200 MA"
    echo "============================== ======== ======== ======== ======== ========"
    csvfix printf -fmt "%30s %8s %8s %8s %8s %8s" -f 1,2,3,4,6,7 ~/tmp/stockquote.txt
    
    rm ~/tmp/stockquote.txt

}

function cloudmap () {

mapTime=$(date -v-30M "+%Y-%m-%d-%H-")
goodTime=""

for min in 00 10 20 30 40 50
do
    checkMapTime="$mapTime$min"
    header=$(curl -sI http://cwb.gov.tw/V7/observe/satellite/Data/s1p/s1p-"$checkMapTime".jpg)
    if [ ${header:9:3} == "200" ]
    then
        goodTime=$checkMapTime
    else
        break
    fi
done

if [ -z $goodTime ]
then
    echo "The sattlelite image for cloudmap is not available!"
else
    curl -s http://cwb.gov.tw/V7/observe/satellite/Data/s1p/s1p-"$goodTime".jpg > ~/tmp/cloudmap.jpg
    # sips -Z 640 ~/tmp/cloudmap.jpg > /dev/null
    magick ~/tmp/cloudmap.jpg -scale 640x640 ~/tmp/cloudmap.jpg
    imgmore ~/tmp/cloudmap.jpg
    rm ~/tmp/cloudmap.jpg
fi

# Get cloud map with high/low pressure lines from this static url
curl -s http://www.cwb.gov.tw/V7/forecast/fcst/Data/SFCcombo.jpg > ~/tmp/cloudmap_pressure.jpg
imgmore ~/tmp/cloudmap_pressure.jpg
rm ~/tmp/cloudmap_pressure.jpg

}

function rainmap () {

mapTime=$(date -v-30M "+%Y%m%d%H")
goodTime=""

for min in 00 10 20 30 40 50
do
    checkMapTime="$mapTime$min"
    header=$(curl -sI http://cwb.gov.tw/V7/observe/radar/Data/HD_Radar/CV1_3600_"$checkMapTime".png)
    if [ ${header:9:3} == "200" ]
    then
        goodTime=$checkMapTime
    else
        break
    fi
done

if [ -z $goodTime ]
then
    echo "The sattlelite image for rainmap is not available!"
else
    curl -s http://cwb.gov.tw/V7/observe/radar/Data/HD_Radar/CV1_3600_"$goodTime".png > ~/tmp/rainmap.png
    magick ~/tmp/rainmap.png -crop 520x387+1750+1216 ~/tmp/rainmap-c.png
    magick ~/tmp/rainmap.png -scale 25% ~/tmp/rainmap-s.png
    # sips -Z 800 ~/tmp/rainmap.png > /dev/null
    imgmore ~/tmp/rainmap-*.png
    rm ~/tmp/rainmap*.png
fi

}

function g () {
    pushd ~/tmp
    $(which googler) -n 5 --lang zh-TW -t y1 "$@"
    popd
}

jMem
getBuf

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
