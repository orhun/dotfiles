#!/usr/bin/env bash

alias v='vim'
alias g='git'
alias c='xclip -selection clipboard'
alias p='xclip -o'
alias y="yank"
alias x="startx > $HOME/.Xoutput"
alias ls='exa --icons --color-scale'
alias ll='ls -lah'
alias bat='bat --theme "TwoDark"'
alias b="bat -p"
alias cg='cargo'
alias cgr='cgrun debug'
alias cgrr='cgrun release'
alias rustc++='rustup update'
alias ktop='bpytop'
alias code='vscodium'
alias bt='bluetoothctl'
alias cap='menyoki -q cap --root --size $(slop -k) png save - | rpaste - 2>/dev/null | c'
alias rec='menyoki -q rec --root --size $(slop -k) gif --gifski save - | rpaste - 2>/dev/null | c'
alias ezrec='menyoki rec -t 10000 -r --select gif --gifski -q 75 save -d'
alias mictest='arecord -vvv -f dat /dev/null'
alias pacman='sudo pacman'
alias pac='pacman'
alias paclogi='paclog --grep="installed|upgraded"'
alias upd='paru -Syuv'
alias sys='systemctl'
alias rm='trash'
alias src="source $HOME/.bashrc"
alias less="less -R"
alias vpn="sudo openvpn --config $HOME/.openvpn/client.ovpn"
alias rst="reset"
alias tlp-stat="sudo tlp-stat"
alias mdp='mdp -sc'
alias tasks='taskwarrior-tui'
alias lswin='xwininfo -tree -root'
alias minecraft="java -jar $HOME/.minecraft/TLauncher*"
alias aqw="$HOME/.aqw/Artix_Games_Launcher-x86_64.AppImage"
alias rebuildpy='pacman -Qoq /usr/lib/python3.8/ | paru -S --rebuild -'
alias dsf='diff-so-fancy'
alias bino='WGPU_BACKEND=gl binocle'
alias chksrv='chkservice'
alias cdj='cd "$(xplr --print-pwd-as-result)"'
alias search-command='compgen -c | sort -u | fzf'
alias rawterm='stty raw; sleep 2; echo; stty cooked'
alias wifi-menu='sudo wifi-menu'
alias xlog="/usr/bin/ls $HOME/.local/share/xorg/Xorg.*.log | fzf | xargs bat"
