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

### custome
export PATH=~/bin:"$PATH"
export PAGER=less
export LESSCHARSET='utf-8'

# man bash
export MYHISTFILE=~/.bash_myhistory
export HISTCONTROL=ignoreboth:erasedups
export HISTTIMEFORMAT="%Y/%m/%d %H:%M:%S:   "
export HISTSIZE=50000
export HISTFILESIZE=50000

show_exit() {
    if [ "$1" -eq 0 ]; then
        return
    fi
    echo -e "\007exit $1"
}

log_history() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') $HOSTNAME:$$ $PWD ($1) $(history 1)" >> $MYHISTFILE
}

prompt_cmd() {
    local s=$?
    show_exit $s;
    log_history $s;
}

end_history() {
    log_history $?;
    echo "$(date '+%Y-%m-%d %H:%M:%S') $HOSTNAME:$$ $PWD (end)" >> $MYHISTFILE
}
PROMPT_COMMAND="prompt_cmd;$PROMPT_COMMAND"

_exit() {
    end_history
    echo -e  "${BRed}Hasta la vista, baby!"
    echo -en "\033[m"
}
trap _exit EXIT

[ -z "$TMPDIR" ] && TMPDIR=/tmp

### Global
#export GOPATH=~/src
#mkdir -p $GOPATH 2>/dev/null
export EDITOR=vim
export LANG=en_US.UTF-8

# Test whether we're in a git repo
is_git_repo() { git rev-parse --is-inside-work-tree &>/dev/null; }

# Prompt setting
if [ "$PLATFORM" = "linux" ]; then
    PS1="\[\e[1;38m\]\u\[\e[1;34m\]@\[\e[1;31m\]\h\[\e[1;30m\]:"
    PS1="$PS1\[\e[0;38m\]\w\[\e[1;35m\]> \[\e[0m\]"
else
    ### git-prompt
    __git_ps1() { :; }
    if [ -f ~/.modules/git-prompt.sh ]; then
        source ~/.modules/git-prompt.sh
    fi
    my__git_ps1() { is_git_repo && echo -e "${Red}$(__git_ps1)${NC}" || :; }
    PROMPT_COMMAND="my__git_ps1;$PROMPT_COMMAND"
    PS1="\[\e[34m\]\u\[\e[1;32m\]@\[\e[0;33m\]\h\[\e[35m\]:"
    PS1="$PS1\[\e[m\]\w\[\e[1;31m\]> \[\e[0m\]"
fi

export FZF_DEFAULT_OPTS='--extended'

# Common aliases
alias ..='cd ..'
alias ld='ls -ld'          # Show info about the directory
alias lla='ls -lAF'        # Show hidden all files
alias ll='ls -lF'          # Show long file information
alias l='ls -1F'           # Show long file information
alias la='ls -AF'          # Show hidden files
alias lx='ls -lXB'         # Sort by extension
alias lk='ls -lSr'         # Sort by size, biggest last
alias lc='ls -ltcr'        # Sort by and show change time, most recent last
alias lu='ls -ltur'        # Sort by and show access time, most recent last
alias lt='ls -ltr'         # Sort by date, most recent last
alias lr='ls -lR'          # Recursive ls

alias cp="cp -i"
alias mv="mv -i"

alias du='du -h'
alias job='jobs -l'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Use if colordiff exists
#if has 'colordiff'; then
#    alias diff='colordiff -u'
#else
#    alias diff='diff -u'
#fi

# vim
alias vi="vim"
alias v="vim"
# Use plain vim.
alias nvim='vim -N -u NONE -i NONE'

# tmux
alias tl='tmux ls'
alias tat='tmux a -t'
alias trt='tmux rename -t'
alias tkt='tmux kill-session -t'
alias tns='tmux new -s'

# git
function trygitcmd(){
if (which git > /dev/null) && (git branch 1>/dev/null 2>/dev/null); then
    command git "$@"
else
    command "$@"
fi
}
alias st='trygitcmd status'
alias co='trygitcmd checkout'
alias cob='trygitcmd checkout -b'
alias br='trygitcmd branch'
alias brm='trygitcmd branch -m'
alias brd='trygitcmd branch -d'
alias brD='trygitcmd branch -D'
alias di='trygitcmd diff --color'
alias ad='trygitcmd add'
alias ada='trygitcmd add -A'
alias adan='trygitcmd add -A -n'
alias ci='trygitcmd commit'
alias cim='trygitcmd commit -m'
alias push='trygitcmd push'
alias pull='trygitcmd pull'
alias tr="git log --graph --pretty='format:%C(yellow)%h%Creset %s %Cgreen(%an)%Creset %Cred%d%Creset'"

alias dstat-full='dstat -Tclmdrn'
alias dstat-mem='dstat -Tclm'
alias dstat-cpu='dstat -Tclr'
alias dstat-net='dstat -Tclnd'
alias dstat-disk='dstat -Tcldr'

# emacs
alias e='emacs -l ~/.emacs.d/init.el'
alias eq='emacs -q'

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# evm
export PATH="$HOME/.evm/bin:$PATH"

# Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# __END__{{{1
# vim:fdm=marker fdc=3 ft=sh ts=4 sw=4 sts=4:
