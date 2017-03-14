
# Setting environment variables
# export PS1="[\h:\033[1m\w\033[0m]$ "
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
alias today="date +'%A, %B%e日, %Y年, %p%l:%M:%S'"
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
alias g="$(which googler) -n 5"
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

# Alias to manage git repository
alias gbranch="git branch -avv"
alias gtag="git tag -ln1"
alias glog="git log --oneline --decorate=short"
alias gmaster="git checkout master"
alias gdevelop="git checkout develop"
alias gmerge="git merge develop"
alias gpush="git push origin master"
alias gvisual="gitk --all &"
alias gstatus="git status -sbvv"
alias gconf="git config --list | more"
alias glastcommitfile="git checkout HEAD"

# Bash function helpers
cd() { builtin cd "$@"; ls; }               # cd then ls;
trash() { command mv "$@" ~/.Trash ; }      # move to ~/.Trash folder
ff() { /usr/bin/find . -name "$@" ; }       # find files match name in arg 1
function v? () {
    while read line
    do
        echo -e "$line"
    done < ~/.vim_runtime/vHint.txt
}
