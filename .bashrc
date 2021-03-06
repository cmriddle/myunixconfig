# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
function find_git_branch {
    local dir=. head
    until [ "$dir" -ef / ]; do
        if [ -f "$dir/.git/HEAD" ]; then
            head=$(< "$dir/.git/HEAD")
            if [[ $head == ref:\ refs/heads/* ]]; then
                git_branch=" ${head#*/*/}"
            elif [[ $head != '' ]]; then
                git_branch=' (detached)'
            else
                git_branch=' (unknown)'
            fi
            return
        fi
        dir="../$dir"
    done
    git_branch=''
}
PROMPT_COMMAND="find_git_branch; $PROMPT_COMMAND"

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
#set a fancy prompt (no-color, unless we know we "want" color)
case "$TERM" in   
   xterm-color) color_prompt=yes;;
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

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias sag='sudo apt-get'
alias lag='ls -al | grep'
alias sublime='subl'
alias df="df -h"
alias du="du -h"
alias ..="cd .."
alias cdd="cd .."
alias cd..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias -- -='cd -'
alias pycharm="pycharm.sh"
alias webstorm="webstorm.sh"
alias docear="docear.sh"
alias zotero="run-zotero.sh"
alias fiji="ImageJ-linux64"


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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
export PS1='\[\e]2;\u@\h:\w\a\]\[\e[32m\][\A]\[\e[34m\]\u\[\e[31m\][\w]\[\e[33m\]>$git_branch $:\[\e[0m\]'


# Set colors for man pages
man() {
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

#openmpi
export PATH=$HOME/opt/openmpi/bin:$PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/opt/openmpi/lib

#relion 1.4
export PATH=$PATH:$HOME/opt/relion-1.4/
alias relion='maingui'

#Chimera
export PATH=$PATH:$HOME/.local/UCSF-Chimera64-1.11/bin

#pytom
export PATH=$PATH:/home/zhaowei/emsoftwares/pytom/bin
export PATH=$PATH:/home/zhaowei/emsoftwares/pytom/frontend

alias pytompage='pytom pytomServer.py -h "ubuntu"'

#Pycharm and webstorm
export PATH=$PATH:/usr/local/pycharm-2016.2.1/bin
export PATH=$PATH:/usr/local/WebStorm-162.1447.27/bin

#zotero
export PATH=$PATH:/usr/local/Zotero_linux-x86_64

#Fiji imageJ
export PATH=$PATH:/usr/local/Fiji.app

#docear
export PATH=$PATH:/usr/local/docear-1.2.0.0_stable_build291

#ICON
export PATH=/home/zhaowei/emsoftwares/Ubuntu64/bin:$PATH
export GOPATH=/home/zhaowei/mygo

#IMOD
source /usr/local/Particle/Particle.sh
export IMOD_PROCESSORS=4
#xmipp
source ~/opt/xmipp/.xmipp.bashrc
test -s ~/Xmipp_dir/.xmipp.bashrc && . ~/Xmipp_dir/.xmipp.bashrc || true


# added by Anaconda3 4.1.1 installer
export PATH="/home/weizhao/opt/anaconda3/bin:$PATH"


