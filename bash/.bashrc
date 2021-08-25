#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Pull in bash alias definitions, if they exist
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

# Pull in bash functions, if they exist
[[ -f ~/.bash_functions ]] && . ~/.bash_functions

PS1='(\u \[\e[37m\]λ\[\e[39m\] \w) '
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

export CHROOT="$HOME/.chroot"
export DOTFILES="$HOME/.dotfiles"
export PKGBUILDS="$HOME/.pkgbuilds"
export PKGS="$HOME/.packages"
export CACHEDIR="/var/lib/repro/cache"
