#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases
[[ -f ~/.bash_functions ]] && . ~/.bash_functions
[[ -f ~/.git_aliases ]] && . ~/.git_aliases
[[ -f ~/.git_functions ]] && . ~/.git_functions

PS1='(\u \[\e[31m\]ζ\[\e[39m\] \w) '
XDG_CONFIG_HOME="$HOME/.config"
PATH="$PATH:$HOME/.cargo/bin"
export DOTFILES="$HOME/.dotfiles"
export ARCH="x86_64"
export LC_ALL="en_US.utf-8"
export LANG="en_US.utf-8"
export TERM="xterm-color"
export VISUAL="vim"
export EDITOR="$VISUAL"
export GPG_TTY=$(tty)
export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/library
export BT_HEADSET="E8:D0:3C:8B:7B:48"
export HISTSIZE=2000

source "$DOTFILES/scripts/scripts/fzf-bash-completion.sh"
source "/usr/share/fzf/key-bindings.bash"
bind -x '"\t": fzf_bash_completion'

