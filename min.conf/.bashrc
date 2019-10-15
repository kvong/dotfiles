# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

alias rm='rm -i'
export PATH=$PATH:$HOME/scripts
alias cd.='cd ..'
alias os='ssh vong@hoare.cs.umsl.edu'
alias wo='ps -aux | grep hoare'
alias vis='vim -O'
alias vit='vim -p'
alias so='source'
alias cd0='cd ~/compiler/p0'
alias cd1='cd ~/compiler/p1'
alias cd2='cd ~/compiler/p2'
alias cd3='cd ~/compiler/p3'
alias cd4='cd ~/compiler/p4'
alias cd5='cd ~/compiler/p5'
alias so='source'

cd(){
	builtin cd "$@" && ls;
}
