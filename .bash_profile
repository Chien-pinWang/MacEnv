
# Set command line editing to vi-style
set -o vi

# Setting environment variables
export PS1="[\h:\w]$ "
export CLICOLOR="true"
export LSCOLORS="gxfxcxdxbxegedabagaced"
export PATH=$HOME/bin:$PATH
export EDITOR=/usr/local/bin/vim
export BC_ENV_ARGS="-l $HOME/.bcrc"
export BROWSER=w3m
export PRJ=~/bin
export R_HOME=$(R RHOME)
export PHPRC=/usr/local/etc/php/7.1/php.ini
export SSID=$(networksetup -getairportnetwork en0 | cut -c 24-)

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
alias RPi="ssh pi@180.176.111.91"
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

function cloudmap () {

    mapTime=$(date -v-30M "+%Y-%m-%d-%H-")
    goodTime=""

    for min in 00 10 20 30 40 50; do
        checkMapTime="$mapTime$min"
        header=$(curl -sI https://www.cwb.gov.tw/V7/observe/satellite/Data/s1p/s1p-"$checkMapTime".jpg)
        if [ ${header:7:3} == "200" ]; then
            goodTime=$checkMapTime
        else
            break
        fi
    done

    if [ -z $goodTime ]; then
        echo "The sattlelite image for cloudmap is not available!"
    else
        curl -s https://www.cwb.gov.tw/V7/observe/satellite/Data/s1p/s1p-"$goodTime".jpg > ~/tmp/cloudmap.jpg
        # sips -Z 640 ~/tmp/cloudmap.jpg > /dev/null
        magick ~/tmp/cloudmap.jpg -scale 1024x1024 ~/tmp/cloudmap.jpg
        imgmore ~/tmp/cloudmap.jpg
        rm ~/tmp/cloudmap.jpg
    fi

    # Get cloud map with high/low pressure lines from this static url
    curl -s https://www.cwb.gov.tw/V7/forecast/fcst/Data/SFCcombo.jpg > ~/tmp/cloudmap_pressure.jpg
    magick ~/tmp/cloudmap_pressure.jpg -scale 125% ~/tmp/cloudmap_pressure.jpg
    imgmore ~/tmp/cloudmap_pressure.jpg
    rm ~/tmp/cloudmap_pressure.jpg
}

function rainmap () {

    mapTime=$(date -v-30M "+%Y%m%d%H")
    goodTime=""

    for min in 00 10 20 30 40 50; do
        checkMapTime="$mapTime$min"
        header=$(curl -sI https://www.cwb.gov.tw/V7/observe/radar/Data/HD_Radar/CV1_3600_"$checkMapTime".png)
        if [ ${header:7:3} == "200" ]; then
            goodTime=$checkMapTime
        else
            break
        fi
    done

    if [ -z $goodTime ]; then
        echo "The sattlelite image for rainmap is not available!"
    else
        curl -s https://www.cwb.gov.tw/V7/observe/radar/Data/HD_Radar/CV1_3600_"$goodTime".png > ~/tmp/rainmap.png
        magick ~/tmp/rainmap.png -crop 520x387+1750+1216 -scale 150% ~/tmp/rainmap-c.png
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

function weather1 () {

clear
echo -e "\033[31;107mCurrent Weather:\033[39;49m"
w3m -dump -no-cookie https://www.cwb.gov.tw/V7/observe/24real/Data/46692.htm | head -n 20
echo
read -n 1 -s -r -p "Press any key to continue..."

clear
echo -e "\033[31;107mWeather Summary:\033[39;49m"
curl -s https://www.cwb.gov.tw/V7/forecast/taiwan/Data/W50_63.txt | textutil -stdin -stdout -format html -inputencoding utf-8 -convert txt
echo -e "\033[31;107m7-Day Forecast:\033[39;49m"
w3m -T text/html -dump -no-cookie https://www.cwb.gov.tw/V7/forecast/taiwan/inc/city/Taipei_City.htm
read -n 1 -s -r -p "Press any key to continue..."

clear
echo -e "\033[31;107mAir Quality:\033[39;49m"
w3m -dump -no-cookie http://aqicn.org/city/taiwan/datong/| head -n 89 | tail -n 40
}

function weather () {
    : "${COLOR_DIM:=\e[2m}"
    : "${COLOR_BOLD:=\e[1;37m}"
    : "${COLOR_GREEN:=\e[32m}"
    : "${COLOR_RED:=\e[31m}"
    : "${COLOR_YELLOW:=\e[33m}"
    : "${COLOR_ORANGE:=\e[38;5;166m}"
    : "${COLOR_PURPLE:=\e[38;5;99}"
    : "${COLOR_DEEPPURPLE:=\e[38;5;200}"
    : "${COLOR_RESET:=\e[00m}"
    clear
    echo -e "\033[31;107m氣象摘要:\033[39;49m"
    # curl -s https://www.cwb.gov.tw/V7/forecast/taiwan/Data/W50_63.txt | textutil -stdin -stdout -format html -inputencoding utf-8 -convert txt
    curl -s https://www.cwb.gov.tw/V7/forecast/taiwan/Data/W50_63.txt | \
        w3m -T text/html -dump | \
        sed -e '$d'

    echo -e "\033[31;107m目前天氣:\033[39;49m"
    i=0
    while read -r date time temp weather windDir windSpeed windLevel rain humidity; do 
        if [[ $i == 0 ]]; then
            if [[ $weather == "X" ]]; then
                weather=""
            else
                weather="$weather, "
            fi
            echo "    在 $time 天氣狀況為 $weather 氣溫 $temp 度, 吹著 $windDir 風, 風力 $windLevel 級."
            echo "    此時相對濕度$humidity%, 今日累積雨量為 $rain mm"
        fi
        i=$(( $i+1 ))
    done< <(w3m -dump -no-cookie -cols 144 \
            https://www.cwb.gov.tw/V7/observe/24real/Data/46692.htm | \
            sed -e '1,2d' -e '9,$d' | \
            awk '{print $1, $2, $3, $5, $6, $7, $9, $(NF-1), $(NF-3)}')
    echo

    echo -e "\033[31;107m三日預報:\033[39;49m"
    report=$(w3m -T text/html -dump -cols 144 -no-cookie \
            https://www.cwb.gov.tw/V7/forecast/taiwan/inc/city/Taipei_City.htm)
    read -r city day1 day2 day3 day4 day5 day6 day7<<<$(echo "$report" | sed -n 3p)
    read -r weekday1 weekday2 weekday3 weekday4 weekday5 weekday6 weekday7<<<$(echo "$report" | sed -n 4p)
    read -r daytime dayWeather1 dayWeather2 dayWeather3 dayWeather4 dayWeather5 dayWeather6 dayWeather7<<<$(echo "$report" | sed -n 5p)
    read -r day1TempLow day1TempHigh day2TempLow day2TempHigh day3TempLow \
    day3TempHigh day4TempLow day4TempHigh day5TempLow day5TempHigh \
    day6TempLow day6TempHigh day7TempLow day7TempHigh<<<$(echo "$report" | \
        sed -n 6p | awk \
    '{print $1, $3, $4, $6, $7, $9, $10, $12, $13, $15, $16, $18, $19, $21}')
    read -r nighttime nightWeather1 nightWeather2 nightWeather3 \
    nightWeather4 nightWeather5 nightWeather6 nightWeather7<<<$(echo "$report" | sed -n 7p)
    read -r night1TempLow night1TempHigh night2TempLow night2TempHigh \
    night3TempLow night3TempHigh night4TempLow night4TempHigh night5TempLow \
    night5TempHigh night6TempLow night6TempHigh night7TempLow \
    night7TempHigh<<<$(echo "$report" | \
        sed -n 8p | awk \
    '{print $1, $3, $4, $6, $7, $9, $10, $12, $13, $15, $16, $18, $19, $21}')
    for i in {1..3}; do
        day="day$i"
        weekday="weekday$i"
        dayWeather="dayWeather$i"
        dayTempLow="day${i}TempLow"
        dayTempHigh="day${i}TempHigh"
        nightWeather="nightWeather$i"
        nightTempLow="night${i}TempLow"
        nightTempHigh="night${i}TempHigh"
        echo "${!day}(${!weekday}):"
        echo "    白天天氣${!dayWeather}, 氣溫${!dayTempLow}至${!dayTempHigh}度; 晚上天氣${!nightWeather}, 氣溫${!nightTempLow}至${!nightTempHigh}度"
    done
    echo
   
    echo -e "\033[31;107m空氣品質:\033[39;49m"
    read -r aqi ignore <<<$(w3m -dump -no-cookie http://aqicn.org/city/taiwan/datong/ | sed -n 54p)
    if (( $(echo "$aqi <= 50" | bc) )); then
        airQuality="良好"
        airColor="${COLOR_GREEN}"
    elif (( $(echo "$aqi <= 100" | bc) )); then
        airQuality="中等"
        airColor="${COLOR_YELLOW}"
    elif (( $(echo "$aqi <= 150" | bc) )); then
        airQuality="不適於敏感族群"
        airColor="${COLOR_ORANGE}"
    elif (( $(echo "$aqi <= 200" | bc) )); then
        airQuality="不健康"
        airColor="${COLOR_RED}"
    elif (( $(echo "$aqi <= 300" | bc) )); then
        airQuality="非常不健康"
        airColor="${COLOR_PURPLE}"
    elif (( $(echo "$aqi <= 500" | bc) )); then
        airQuality="危險"
        airColor="${COLOR_DEEPPURPLE}"
    fi
    echo -e "    ${airColor}目前空氣品質$airQuality, AQI: $aqi${COLOR_RESET}"
    echo 

}

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
