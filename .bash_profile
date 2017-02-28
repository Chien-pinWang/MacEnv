
# Setting environment variables
export PS1="\h:\w\$ "
export CLICOLOR="true"
export LSCOLORS="gxfxcxdxbxegedabagaced"
export PATH=/usr/local/go/bin:$HOME/bin:/usr/local/mysql/bin:$PATH
export EDITOR=/usr/bin/vim
export PRJ=~/bin
export R_HOME=$(R RHOME)
export BC_ENV_ARGS="-l $HOME/.bcrc"
export BROWSER=w3m

# Source other settings
source ~/.googler  # aliases for command line google search

# Aliases to execute commands
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
alias waves="php ~/bin/Buoy/index.php"
alias schd="crontab -e"
alias tree="tree -d | more"
alias vsplit="vi -O"
alias vstack="vi -o"
alias vtab="vi -p"
alias phpweb="php -S 127.0.0.1:8080 &"
alias www="w3m -B"
alias notify="vi ~/bin/OSNotification.sh; crontab -e"
alias g="$(which googler) -n 7"

# Aliases for PHP programming
alias class="grep -n -w --color=auto -e 'class' -e 'protected' -e 'public' -e 'const ' -e 'namespace' -e 'use'"
alias phpSnippets="vi ~/.vim_runtime/sources_non_forked/vim-snippets/snippets/php.snippets"
alias mySnippets="vi ~/.vim_runtime/snippets/_.snippets"

# Aliases to manage various servers on this machine
# alias httpdconf="ll /etc/apache2/httpd.conf"
alias httpdconf="ll /usr/local/etc/apache2/2.4/httpd.conf"
# alias httpdvhosts="ll /etc/apache2/extra/httpd-vhosts.conf"
alias httpdvhosts="ll /usr/local/etc/apache2/2.4/extra/httpd-vhosts.conf"
alias httpdrestart="sudo apachectl graceful"
alias httpderror="tail /var/log/apache2/error_log"
alias phpconf="ll /etc/php.ini"
alias mysqlstop="sudo launchctl unload -F /Library/LaunchDaemons/com.oracle.oss.mysql.mysqld.plist"
alias mysqlstart="sudo launchctl load -F /Library/LaunchDaemons/com.oracle.oss.mysql.mysqld.plist"
alias mysqlconf="ll /Library/LaunchDaemons/com.oracle.oss.mysql.mysqld.plist"
alias Rconf="ll $R_HOME/etc/Renviron"
alias Rinit="vi ~/.Rprofile"

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
