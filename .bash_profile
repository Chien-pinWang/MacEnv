
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
source ~/.jrnl.sh           # aliases for jrnl routines
source ~/.gitalias          # aliases for git routines
source ~/.ledger.sh         # aliases for ledger routines

# Aliases to execute commands
alias cmds="clear; more -e ~/cmds"
alias webex="open https://cisco.webex.com/join/yunko"
alias swim="curl -s http://taipeidt.com/tc/iwlink.php | w3m -T text/html -dump"
alias iotaseed="cat /dev/random |LC_ALL=C tr -dc 'A-Z9' | fold -w 81 | head -n 1 | qrencode -o ~/Desktop/IOTASeed.png; imgmore ~/Desktop/IOTASeed.png"
alias inspire='sed -n "$((23226+RANDOM%8013)) p" ~/doc/和合本聖經.txt | awk "{print \$3 \$4 \$5}"'
alias wawawa="youtube-dl -q --no-mtime --extract-audio --audio-format mp3 --audio-quality 0 -o '%(title)s.%(ext)s'"
alias apple="pushd ~/tmp; w3m http://www.appledaily.com.tw; popd"
alias udn="pushd ~/tmp; w3m https://udn.com/news/index; popd"
alias liberty="pushd ~/tmp; w3m http://www.ltn.com.tw; popd"
alias industries="pushd ~/tmp; w3m https://money.udn.com/money/cate/5591; popd"
alias news="newsboat -r"
alias sdp="open ~/prj/SDP/Personal\ SDP\ 2018.gsheet"
alias finance="open ~/prj/SDP/Personal\ Finance.gsheet"
alias buoys="curl -s http://www.cwb.gov.tw/V7/marine/sea_condition/cht/tables/C6AH2.html | w3m -T text/html -dump | head -n 37; read -n 1 -s -r -p 'Press any key to continue...'; echo; curl -s http://www.cwb.gov.tw/V7/marine/sea_condition/cht/tables/46694A.html | w3m -T text/html -dump | head -n 37; read -n 1 -s -r -p 'Press any key to continue...'; echo; curl -s http://www.cwb.gov.tw/V7/marine/sea_condition/cht/tables/46708A.html | w3m -T text/html -dump | head -n 37;"
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
alias ll="ls -FGlhp"
alias less="less -FSRXc"
alias cls="clear"
alias src="source ~/.bash_profile"
alias now="date +'%T'"
alias psg="ps aux | grep --color=auto"
# alias path="echo -e ${PATH//:/\\n}"
# alias calc="bc -q"
alias calc="~/bin/calc.sh"
alias sheet="sc"
alias slide="mdp"
alias waves="php ~/bin/Buoy/index.php"
alias cron="crontab -e"
alias tree="tree -d | more"
alias phpweb="php -S 127.0.0.1:8080 &"
alias w="pushd ~/tmp; w3m -B; popd"
alias notify="vi ~/bin/OSNotification.sh; crontab -e"
# alias g="pushd ~/tmp; $(which googler) -n 5 --lang zh-TW; popd"
# alias blockchain="$(which googler) -n 5 -N blockchain"
alias blockchain="vi ~/prj/blockchain/blockchain.txt +:tabedit +':W3m https://www.google.com.tw/search?q=blockchain&tbm=nws'"
# alias weather='curl -sH "Accept-Language: zh" wttr.in/Taipei?2n | head -n 28; w3m -dump -no-cookie http://cwb.gov.tw/V7/observe/24real/Data/46692.htm | head -n 10'
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

# Aliases to move around file systems
alias 2bin="cd ~/bin"
alias 2prj='cd $PRJ'     # Type "PRJ=<path/to/prj/root>" at command line to reset active project
alias tmp="pushd ~/tmp"
alias ..="cd .."
alias ...="cd ../.."
alias ~="cd ~"

# Real quick shortcut to frequently used items
alias budget="budget"
alias mail="mutt"

alias macStorage="system_profiler SPStorageDataType | head -n 6"

# Bash function helpers
cd() { builtin cd "$@"; ls; }               # cd then ls;
trash() { command mv "$@" ~/.Trash ; }      # move to ~/.Trash folder
ff() { /usr/bin/find . -name "*$@*" ; }     # find files match name in arg 1
function v? () {
    while read line
    do
        echo -e "$line"
    done < ~/.vim/vHint.txt
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
        stocks="^TWII 5434.TW 2330.TW 3008.TW 2049.TW"
        ;;
    "us")
        stocks="^DJI ^IXIC AAPL GOOG FB AMZN MSFT NVDA CR"
        ;;
    "index")
        stocks="^DJI ^IXIC ^VIX ^TWII ^BSESN"
        ;;
    "commod")
        stocks="^HUI GC=F CL=F"
        ;;
    "currency")
        stocks="USDTWD=X USDCNY=X USDJPY=X USDEUR=X"
        ;;
    "crypto")
        # echo "Bitcoin: \$$(curl -s https://coinmarketcap-nexuist.rhcloud.com/api/btc | jq '.price.usd')"
        # echo "Ether: \$$(curl -s https://coinmarketcap-nexuist.rhcloud.com/api/eth | jq '.price.usd')"
        stocks="BTCUSD=X ETHUSD=X"
        ;;
    *)
        stocks="^DJI ^TWII AAPL GOOG FB 5434.TW 2330.TW USDTWD=X"
        ;;
    esac

    ~/bin/ticker.sh $stocks

#    url="http://download.finance.yahoo.com/d/quotes.csv?s=$stocks&f=nl1c1p2xm3m4"
#    curl -s "${url}" > ~/tmp/stockquote.txt

#    echo "                         Quote    Price    Delta  Delta %    50 MA   200 MA"
#    echo "============================== ======== ======== ======== ======== ========"
#    csvfix printf -fmt "%30s %8s %8s %8s %8s %8s" -f 1,2,3,4,6,7 ~/tmp/stockquote.txt
    
#    rm ~/tmp/stockquote.txt

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
    imgmore ~/tmp/rainmap-s.png
    imgmore ~/tmp/rainmap-c.png
    rm ~/tmp/rainmap*.png
fi

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

function weather () {

clear
echo -e "\033[31;107mCurrent Weather:\033[39;49m"
w3m -dump -no-cookie https://www.cwb.gov.tw/V7/observe/24real/Data/46692.htm | head -n 20
echo
read -n 1 -s -r -p "Press any key to continue..."

clear
echo -e "\033[31;107m7-Day Forecast:\033[39;49m"
w3m -T text/html -dump -no-cookie https://www.cwb.gov.tw/V7/forecast/taiwan/inc/city/Taipei_City.htm
read -n 1 -s -r -p "Press any key to continue..."

clear
echo -e "\033[31;107mWeather Summary:\033[39;49m"
curl -s https://www.cwb.gov.tw/V7/forecast/taiwan/Data/W50_63.txt | textutil -stdin -stdout -format html -inputencoding utf-8 -convert txt
read -n 1 -s -r -p "Press any key to continue..."

clear
echo -e "\033[31;107mAir Quality:\033[39;49m"
w3m -dump -no-cookie http://aqicn.org/city/taiwan/datong/| head -n 89 | tail -n 40
}

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
