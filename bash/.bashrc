#
# ~/.bashrc
# The beginning of of everything.
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Pull in bash alias/functions definitions
while read -r f; do source "$f"; done < <( find "$HOME/.bashrc.d/" -name "*.sh" | sort )

# Helper utilities
[[ -f /etc/profile.d/autojump.sh ]] && source /etc/profile.d/autojump.sh
[[ -f /usr/share/fzf/key-bindings.bash ]] && source /usr/share/fzf/key-bindings.bash
[[ -f "$HOME/scripts/fzf-bash-completion.sh" ]] && source "$HOME/scripts/fzf-bash-completion.sh"

# Settings
shopt -s autocd
shopt -s histappend
stty -ixon
bind -x '"\t": fzf_bash_completion'

# Prompt
PS1='(\u \[\e[31m\]ζ\[\e[39m\] \w) '

# General variables
XDG_CONFIG_HOME="$HOME/.config"
PATH="$PATH:$HOME/.cargo/bin:$HOME/scripts"
export ARCH="x86_64"
export LC_ALL="en_US.utf-8"
export LC_CTYPE="en_US.utf-8"
export LANG="en_US.utf-8"
export TERM="xterm-color"
export VISUAL="vim"
export EDITOR="$VISUAL"
export GPG_TTY=$(tty)
export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/library
export BT_HEADSET="00:1B:66:10:B6:B0"
export HISTTIMEFORMAT="%h %d %H:%M:%S "
export HISTSIZE=2000
export HISTCONTROL=ignorespace:erasedups

# Workspace variables
export WORKSPACE="$HOME/g"
export CHROOT="$HOME/.chroot"
export DOTFILES="$HOME/.dotfiles"
export PKGBUILDS="$HOME/.pkgbuilds"
export PKGS="$HOME/.packages"
export CACHEDIR="/var/lib/repro/cache"
