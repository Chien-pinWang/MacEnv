
# Shortcuts for commands with commonly used options
alias ls="ls -FGhp"
alias ll="ls -FGlhp"
alias cp="cp -iv"
alias mv="mv -iv"
alias less="less -FSRXc"
alias cls="clear"
alias psg="ps aux | grep --color=auto"
alias now="date +'%T'"
alias cron="crontab -e"
alias tree="tree -d | more"
alias def="clear; /usr/local/bin/dict"
alias agrep="alias | grep "
alias src="source ~/.bash_profile"
alias calc="~/bin/calc.sh"
alias sheet="sc"
alias slide="mdp"
alias phpweb="php -S 127.0.0.1:8080 &"
alias Xmas="tDepends 76"

# Scrapping information from the Internet
alias w="pushd ~/tmp; w3m -B; popd"
alias swim="curl -s http://taipeidt.com/tc/iwlink.php | w3m -T text/html -dump"
alias wawawa="youtube-dl -q --no-mtime --extract-audio --audio-format mp3 --audio-quality 0 -o '%(title)s.%(ext)s'"
alias apple="pushd ~/tmp; w3m http://www.appledaily.com.tw; popd"
alias cnn="pushd ~/tmp; w3m http://m.cnn.com; popd"
alias udn="pushd ~/tmp; w3m https://udn.com/news/index; popd"
alias liberty="pushd ~/tmp; w3m http://www.ltn.com.tw; popd"
alias economic="pushd ~/tmp; w3m https://money.udn.com/money/index; popd"
alias news="newsboat -r"
alias buoys="curl -s https://www.cwb.gov.tw/V7/marine/sea_condition/cht/tables/C6AH2.html | w3m -T text/html -dump | head -n 37; read -n 1 -s -r -p 'Press any key to continue...'; echo; curl -s https://www.cwb.gov.tw/V7/marine/sea_condition/cht/tables/46694A.html | w3m -T text/html -dump | head -n 37; read -n 1 -s -r -p 'Press any key to continue...'; echo; curl -s https://www.cwb.gov.tw/V7/marine/sea_condition/cht/tables/46708A.html | w3m -T text/html -dump | head -n 37;" 
alias waves="php ~/bin/Buoy/index.php"
alias blockchain="vi ~/prj/blockchain/blockchain.txt +:tabedit +':W3m https://www.google.com.tw/search?q=blockchain&tbm=nws'"
alias fundCharts="open 'https://fund.cnyes.com/chart/chartstudy.aspx?code=B15%2C086&mobile=true&country=fund&market=B&divwidth=150%25&divheight=700' 'https://fund.cnyes.com/chart/chartstudy.aspx?code=B18%2C004&mobile=true&country=fund&market=B&divwidth=150%25&divheight=700'"

# Shortcuts to start vim
alias v="/usr/local/bin/vim"
alias vSplit="vi -O"
alias vStack="vi -o"
alias vTab="vi -p"
alias notify="vi ~/bin/OSNotification.sh; crontab -e"

# Misc. shortcuts
alias iotaseed="cat /dev/random |LC_ALL=C tr -dc 'A-Z9' | fold -w 81 | head -n 1 | qrencode -o ~/Desktop/IOTASeed.png; imgmore ~/Desktop/IOTASeed.png"
alias inspire='sed -n "$((23226+RANDOM%8013)) p" ~/doc/和合本聖經.txt | awk "{print \$3 \$4 \$5}"'
alias sdp="open ~/prj/SDP/Personal\ SDP\ 2018.gsheet"
alias finance="open ~/prj/SDP/Personal\ Finance.gsheet"
alias setSSID="export SSID=$(networksetup -getairportnetwork en0 | cut -c 24-)"

# Aliases to move around file systems
alias 2bin="cd ~/bin"
alias 2prj='cd $PRJ'     # Type "PRJ=<path/to/prj/root>" at command line to reset active project
alias tmp="pushd ~/tmp"
alias ..="cd .."
alias ...="cd ../.."
alias ~="cd ~"

# alias path="echo -e ${PATH//:/\\n}"
# alias calc="bc -q"
# alias g="pushd ~/tmp; $(which googler) -n 5 --lang zh-TW; popd"
# alias blockchain="$(which googler) -n 5 -N blockchain"
# alias weather='curl -sH "Accept-Language: zh" wttr.in/Taipei?2n | head -n 28; w3m -dump -no-cookie http://cwb.gov.tw/V7/observe/24real/Data/46692.htm | head -n 10'
# alias truecrypt="/Applications/TrueCrypt.app/Contents/MacOS/TrueCrypt --text"
# alias pwd="/Applications/TrueCrypt.app/Contents/MacOS/TrueCrypt --text --password=SY42568F4 --mount ~/Dropbox/TrueCryptVolume /Volumes/TrueCrypt"
# alias xpwd="/Applications/TrueCrypt.app/Contents/MacOS/TrueCrypt --text --dismount /Volumes/TrueCrypt"


# Bash function helpers
function cd() { builtin cd "$@"; ls; }               # cd then ls;
function trash() { command mv "$@" ~/.Trash ; }      # move to ~/.Trash folder
function ff() { /usr/bin/find . -type d \( -path ./Library -o -path ./.npm -o -path ./.cache \) -prune -o -name "*$@*" ; }     # find files match name in arg 1
function pushd() { command pushd "$@" > /dev/null; }
function popd() { command popd "$@" > /dev/null; }
function man() {
    env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

function v? () {
    while read line
    do
        echo -e "$line"
    done < ~/.vim/vHint.txt
}

