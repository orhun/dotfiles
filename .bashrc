#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias code='vscodium'
PS1='(\u \e[36mλ\e[39m \W) '
export GPG_TTY=$(tty)
export XDG_CONFIG_HOME="$HOME/.config"
