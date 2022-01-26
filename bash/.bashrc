#
# ~/.bashrc
# The beginning of of everything.
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Pull in bash alias/functions definitions
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases
[[ -f ~/.bash_functions ]] && . ~/.bash_functions
[[ -f ~/.git_aliases ]] && . ~/.git_aliases
[[ -f ~/.git_functions ]] && . ~/.git_functions
[[ -f ~/.pkg_aliases ]] && . ~/.pkg_aliases
[[ -f ~/.pkg_functions ]] && . ~/.pkg_functions

# Helper utilities
[[ -f /usr/share/doc/pkgfile/command-not-found.bash ]] && source /usr/share/doc/pkgfile/command-not-found.bash
[[ -f /etc/profile.d/autojump.sh ]] && source /etc/profile.d/autojump.sh
[[ -f /usr/share/fzf/key-bindings.bash ]] && source /usr/share/fzf/key-bindings.bash

# Settings
shopt -s autocd
shopt -s histappend
stty -ixon

# Prompt
PS1='(\u \[\e[31m\]ζ\[\e[39m\] \w) '

# General variables
XDG_CONFIG_HOME="$HOME/.config"
PATH="$PATH:$HOME/.cargo/bin"
export ARCH="x86_64"
export LC_ALL="en_US.utf-8"
export LC_CTYPE="en_US.utf-8"
export LANG="en_US.utf-8"
export TERM="xterm-color"
export VISUAL="vim"
export EDITOR="$VISUAL"
export GPG_TTY=$(tty)
export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/library
export BT_HEADSET="E8:D0:3C:8B:7B:48"
export BT_CONTROLLER="00:1A:7D:DA:71:15"
export HISTTIMEFORMAT="%h %d %H:%M:%S "
export HISTSIZE=2000
export HISTCONTROL=ignorespace:erasedups

# Packaging related variables
export CHROOT="$HOME/.chroot"
export DOTFILES="$HOME/.dotfiles"
export PKGBUILDS="$HOME/.pkgbuilds"
export PKGS="$HOME/.packages"
export CACHEDIR="/var/lib/repro/cache"
