# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias vi='vim -O'
alias cd.='cd ..'
alias chk="ps -aux | grep vong"
alias wo='who'
alias is="ipcs | ps -aux | grep vong"
alias cd1="cd ~/vong.1"
alias cd2="cd ~/vong.2"
alias cd3="cd ~/vong.3"
alias cd4="cd ~/vong.4"
alias cd5="cd ~/vong.5"
alias cd6="cd ~/vong.6"

cd(){
     builtin cd "$@" && ls;
}

