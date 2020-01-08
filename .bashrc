# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=normal -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


#Alias
alias desk='cd ~/Desktop'
alias down='cd ~/Downloads'
alias scripts='cd ~/Scripts'
alias cd.='cd ..'
alias cdd='dirtree'
alias py='python3'
alias ssh='myssh'
alias delmar='myssh ksv3b4@delmar.umsl.edu'
alias vis='vim -O'
alias vi='vim -p'
alias so='source'
alias sob='source ~/.bashrc && notify-send "<b>Updated</b>" ".bashrc updated!" -i terminal'
alias start='WorkSpace'
#alias sus='/home/blank/.config/i3/i3lock-fancy/i3lock-fancy -gp && systemctl suspend'
alias sus='/home/blank/Scripts/i3lock-fancy -gp && systemctl suspend'
alias note='notify-note'
alias enote='vi ~/Notes/notes'
alias pm='pomodoro > /dev/null 2>&1 &'
alias osmc='ssh osmc@192.168.1.9'
alias install='notify-install'
alias ranger='urxvt -depth 24 -e "ranger" > /dev/null 2>&1 &'
alias vpn='sudo openvpn /etc/openvpn/ovpn_tcp/ca916.nordvpn.com.tcp.ovpn'
alias proc='ps -aux'
alias brc='vi ~/.bashrc'
alias clonedot='git clone https://github.com/kvong/dotfiles.git'

cd(){
    builtin cd "$@" && ls;
}

mkcd(){
    mkdir -p "$*"
    cd "$*"
}

printf "\033[01;36m┐\n"
export PS1="\[\033[01;36m\]├─[\[\033[01;36m\]\[\033[01;37m\]blank\[\033[01;36m\]]──\[\033[01;36m\][\[\033[01;37m\]$(date +'%I:%S%p')\[\033[01;36m\]]──\[\033[01;37m\]\[\033[01;36m\][\[\033[01;37m\]\w/\[\033[01;36m\]]\[\033[01;32m\]:$\n\[\033[01;36m\]├────➤ \[\033[01;37m\]"
export PATH="$PATH:/home/blank/Scripts"

export PATH="${PATH}:${HOME}/.local/bin/"

#export PATH=$PATH:$HOME/Library/Python/2.7/bin
#powerline-daemon -q
#POWERLINE_BASH_CONTINUATION=1
#POWERLINE_BASH_SELECT=1
#. /usr/local/lib/python2.7/dist-packages/powerline/bindings/bash/powerline.sh

#note

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/home/blank/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
#    if [ -f "/home/blank/anaconda3/etc/profile.d/conda.sh" ]; then
#        . "/home/blank/anaconda3/etc/profile.d/conda.sh"
#    else
#        export PATH="/home/blank/anaconda3/bin:$PATH"
#    fi
#fi
#unset __conda_setup
# <<< conda initialize <<<

set -o vi
