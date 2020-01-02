#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='(\u \e[36mλ\e[39m \W) '
alias ls='ls --color=auto'
alias code='vscodium'
export GPG_TTY=$(tty)
export XDG_CONFIG_HOME="$HOME/.config"
export PATH="$PATH:$HOME/.cargo/bin"