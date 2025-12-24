#!/usr/bin/env bash
#
# ~/.bashrc
# The beginning of of everything.
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Pull in bash alias/functions definitions
while read -r f; do source "$f"; done < <(find "$HOME/.bashrc.d/" -name "*.sh" | sort)

# Helper utilities
[[ -f /etc/profile.d/autojump.sh ]] && source /etc/profile.d/autojump.sh
[[ -f /usr/share/fzf/key-bindings.bash ]] && source /usr/share/fzf/key-bindings.bash
[[ -f "$HOME/scripts/fzf-bash-completion.sh" ]] && source "$HOME/scripts/fzf-bash-completion.sh"

# Settings
shopt -s autocd
shopt -s histappend
stty -ixon
bind -x '"\t": fzf_bash_completion'
bind '"\ec": "$EDITOR .\n"'

# Prompt
PS1='(\u \[\e[34m\]ζ\[\e[39m\] \w) '

# General variables
XDG_CONFIG_HOME="$HOME/.config"
PATH="$PATH:$HOME/.cargo/bin:$HOME/scripts:$HOME/.local/bin:$HOME/.local/share/bob/nvim-bin:/var/lib/snapd/snap/bin:/drv/rustrover/RustRover-2025.2/bin"
export ARCH="x86_64"
export LC_ALL="en_US.utf-8"
export LC_CTYPE="en_US.utf-8"
export LANG="en_US.utf-8"
export TERM="xterm-256color"
export VISUAL="nvim"
export EDITOR="nvim"
export GPG_TTY="$(tty)"
export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/library
export HISTTIMEFORMAT="%h %d %H:%M:%S "
export HISTSIZE=2000
export HISTCONTROL=ignorespace:erasedups

# Workspace variables
export WORKSPACE="$HOME/gh"
export CHROOT="$HOME/.chroot"
export DOTFILES="$HOME/.dotfiles"
export PKGBUILDS="$HOME/pkgbuilds"
export AUR_PKGS="$PKGBUILDS/aur"
export EXTRA_PKGS="$PKGBUILDS/extra"
export ALPINE_CHROOT="/alpine"
export APKBUILDS="$HOME/apkbuilds"
export APORTS="$WORKSPACE/aports"
export CACHEDIR="/var/lib/repro/cache"
export ANDROID_HOME="$HOME/Android/Sdk"
export WINEPREFIX="/drv/wine"

# Run zellij when connected via SSH
if [[ $- =~ i ]] && [[ -n "$SSH_CONNECTION" ]]; then
	cat /etc/motd 2>/dev/null
	zellij attach --create "${SSH_TTY#/dev/pts/*}" 2>/dev/null && exit
fi

# Initialize directory jumper
eval "$(zoxide init bash)"

# Start zellij
term=$(basename "$(cat "/proc/$PPID/comm")")
[[ "$term" != "wezterm"* ]] && eval "$(zellij setup --generate-auto-start bash)"

# Initialize starship prompt
eval "$(starship init bash)"
