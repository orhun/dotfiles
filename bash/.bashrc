#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='(\u \[\e[35m\]λ\[\e[39m\] \W) '
XDG_CONFIG_HOME="$HOME/.config"
PATH="$PATH:$HOME/.cargo/bin"
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8
export TERM=xterm-color
export VISUAL=vim
export EDITOR="$VISUAL"
export GPG_TTY=$(tty)
export IRCNICK="orhun"
export IRCNAME="orhun"
export IRCSERVER=irc.freenode.net
alias ls='exa --icons --color-scale'
alias cat='bat --theme "TwoDark"'
alias rm="rm -i"
alias cg='cargo'
alias code='vscodium'
alias bx='cp437 BitchX'
