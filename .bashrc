#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='(\u \e[36mλ\e[39m \W) '
GPG_TTY=$(tty)
XDG_CONFIG_HOME="$HOME/.config"
PATH="$PATH:$HOME/.cargo/bin"
alias ls='ls --color=auto'
alias code='vscodium'