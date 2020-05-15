#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='(\u \e[35mλ\e[39m \W) '
XDG_CONFIG_HOME="$HOME/.config"
PATH="$PATH:$HOME/.cargo/bin"
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8
export TERM=xterm-color
export VISUAL=vim
export EDITOR="$VISUAL"
export GPG_TTY=$(tty)
alias ls='ls --color=auto'
alias rm="rm -i"
alias code='vscodium'
alias clippy='cargo clippy -- -A clippy::tabs-in-doc-comments -D warnings'
