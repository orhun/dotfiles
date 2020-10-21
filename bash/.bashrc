#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Pull in bash alias definitions, if they exist
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

PS1='(\u \[\e[37m\]λ\[\e[39m\] \W) '
XDG_CONFIG_HOME="$HOME/.config"
PATH="$PATH:$HOME/.cargo/bin"
export CHROOT=$HOME/.chroot
export DOTFILES=$HOME/.dotfiles
export PKGBUILDS=$HOME/.pkgbuilds
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8
export TERM=xterm-color
export VISUAL=vim
export EDITOR="$VISUAL"
export GPG_TTY=$(tty)
export IRCNICK="orhun"
export IRCNAME="orhun"
export IRCSERVER=irc.freenode.net
