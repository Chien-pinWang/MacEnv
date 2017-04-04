
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

# Source other settings
source ~/.googler       # aliases for command line google search
source ~/.taskwarrior   # aliases for task routines
source ~/.jrnl          # aliases for jrnl routines
source ~/.gitalias      # aliases for git routines
source ~/.ledger        # aliases for ledger routines

# Aliases to execute commands
alias v="/usr/local/bin/vim"
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
alias nls="jrnl -on today --short"
alias nll="jrnl -on today"
alias ne="jrnl -on today --edit"
alias cron="crontab -e"
alias tree="tree -d | more"
alias phpweb="php -S 127.0.0.1:8080 &"
alias w="w3m -B"
alias notify="vi ~/bin/OSNotification.sh; crontab -e"
alias g="$(which googler) -n 5 --lang zh-TW"
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
alias ..="cd .."
alias ...="cd ../.."
alias ~="cd ~"

# Real quick shortcut to frequently used items
alias cash="lCashBal"
alias budget="lBudget"
alias spent="lExp mtd"
alias debt="lDebt"
alias trx="lNew"
alias bill="tBill"
alias next="tActive"
alias review="tReview"
alias due="tWeek"
alias overdue="tOverdue"
alias checkoff="tCheck"
alias mail="mutt"

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
    echo "$1" >> ~/tmp/wip.buf
}

function getBuf () {
    if [ -f ~/tmp/wip.buf ]
    then
        echo -e "\033[31;107mTHERE ARE WORK-IN-PROGRESS...\033[39;49m"
        cat ~/tmp/wip.buf
    else
        echo -e "\033[31;107mThere is no work-in-progress.\033[39;49m"
    fi
}

function today () {
    if [ -z $1 ]
    then
        verbose="-v"
    else
        verbose="$1"
    fi
    datestring=$(date +'\033[31;107m%A, %B%e日, %Y年, %p%l:%M:%S\033[39;49m')
    echo -e "$datestring"
    case "$verbose" in
        "-vvv")
            wttrConfig="3n"
            ;;
        "-vv")
            wttrConfig="2n"
            ;;
        *)
            wttrConfig="0"
            ;;
    esac
    # curl -sH "Accept-Language: ${LANG%_*}" wttr.in/"${1:-Taipei}"?2n | head -n 28
    curl -sH "Accept-Language: ${LANG%_*}" wttr.in/Taipei?"$wttrConfig" | head -n 28
    read -p "Press any key to continue..." -n 1
    echo ""
    echo -e "\033[31;107mMemorables:\033[39;49m"
    jToday --short
    echo ""
    echo -e "\033[31;107mSpent Today:\033[39;49m"
    ledger -f $ledger register -b today -e tomorrow -R ^Expenses and not Expenses:Cash
    echo ""
    echo -e "\033[31;107mCash Balance:\033[39;49m"
    ledger -f $ledger balance -R Expenses:Cash
    echo ""
    next
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
    jrnl < ~/prj/MacBookPro/.jrnl/template.txt
    jrnl -1 --edit
}

function budget () {
    lbudget "$@"
}

jMem
getBuf
