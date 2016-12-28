
# Aliases to execute commands
alias cp="cp -iv"
alias mv="mv -iv"
alias ls="ls -FGhp"
alias ll="ls -FGlAhp"
alias less="less -FSRXc"
alias cls="clear"
alias waves="php ~/bin/Buoy/index.php"
alias now="date +'%T'"
alias psg="ps aux | grep"
alias path="echo -e ${PATH//:/\\n}"
alias calc="bc -q"

# Aliases to manage various servers on this machine
alias httpdconf="ll /etc/apache2/httpd.conf"
alias httpdvhosts="ll /etc/apache2/extra/httpd-vhosts.conf"
alias httpdrestart="sudo apachectl graceful"
alias httpderror="tail /var/log/apache2/error_log"

# Aliases to move around file systems
alias 2bin="cd ~/bin"
alias ..="cd .."
alias ...="cd ../.."
alias ~="cd ~"

# Alias to manage git repository
alias gbranch="git branch -avv"
alias gtag="git tag -ln1"
alias glog="git log --decorate=full"
alias gmaster="git checkout master"
alias gdevelop="git checkout develop"
alias gmerge="git merge develop"
alias gpush="git push origin master"
alias gvisual="gitk --all &"

# Bash function helpers
cd() { builtin cd "$@"; ls; }               # cd then ll;
trash() { command mv "$@" ~/.Trash ; }      # move to ~/.Trash folder
ff() { /usr/bin/find . -name "$@" ; }       # find files match name in arg 1

# Setting environment variables
export PS1="\h:\w\$ "
export CLICOLOR="true"
export LSCOLORS="gxfxcxdxbxegedabagaced"
export PATH=$HOME/bin:/usr/local/mysql/bin:$PATH
