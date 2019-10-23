#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias xc='vscodium'
PS1='[\u@\h \W]\$ '
export GPG_TTY=$(tty)
export XDG_CONFIG_HOME="$HOME/.config"