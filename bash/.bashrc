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
bind -x '"\C-y": yank_last_command'

# Prompt
PS1='(\u \[\e[34m\]🐀\[\e[39m\] \w) '

# General variables
XDG_CONFIG_HOME="$HOME/.config"
PATH="$PATH:$HOME/.cargo/bin:$HOME/scripts:$HOME/.local/bin:$HOME/.local/share/bob/nvim-bin:/var/lib/snapd/snap/bin"
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
export HISTSIZE=4200000
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
export WINEPREFIX="/drv2/wine"

# Run zellij when connected via SSH
if [[ $- =~ i ]] && [[ -n "$SSH_CONNECTION" ]]; then
	cat /etc/motd 2>/dev/null
	zellij attach --create "${SSH_TTY#/dev/pts/*}" 2>/dev/null && exit
fi

# Initialize directory jumper
eval "$(zoxide init bash)"

# Start zellij
term=$(basename "$(cat "/proc/$PPID/comm")")
[[ "$term" != "wezterm"* && "$term" != "ratty"* ]] && eval "$(zellij setup --generate-auto-start bash)"

# Initialize starship prompt
eval "$(starship init bash)"

# Initialize flyline prompt
if [[ $- == *i* && "$term" != "ratty" ]] && enable -f /usr/lib/bash/libflyline.so flyline; then
	flyline key bind Ctrl+f 'always=insertString(fg)+submitOrNewline'
	flyline key bind Alt+Enter 'always=insertString(tere)+submitOrNewline'
	flyline key bind Alt+c 'always=insertString($EDITOR .)+submitOrNewline'
	flyline key bind Ctrl+Enter always=runAgentMode
	flyline set-agent-mode \
    --system-prompt "Be concise. Answer with a JSON array of at most 3 items with objects containing: command and description. Command will be a Bash command." \
    --trigger-prefix ': ' \
    --command 'codex -a never exec -m gpt-5.6-luna --skip-git-repo-check --ephemeral --color always'
fi
