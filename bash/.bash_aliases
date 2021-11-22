#!/usr/bin/env bash

alias v='vim'
alias g='git'
alias c='xclip -selection clipboard'
alias p='xclip -o'
alias x='startx'
alias ls='exa --icons --color-scale'
alias ll='ls -lah'
alias bat='bat --theme "TwoDark"'
alias cg='cargo'
alias rustc++='rustup update'
alias cgr='cgrun debug'
alias cgrr='cgrun release'
alias ktop='bpytop'
alias code='vscodium'
alias bt='bluetoothctl'
alias cap='menyoki -q cap --root --size $(slop -k) png save - | rpaste - 2>/dev/null | c ; notify'
alias rec='menyoki -q rec --root --size $(slop -k) gif --gifski save - | rpaste - 2>/dev/null | c ; notify'
alias ezrec='menyoki rec -r --select gif --gifski -q 75 save -d'
alias notify='notify-send --urgency=normal "$([ $? -eq 0 ] && echo "Completed" || echo "Failed"): $(history | tail -n1 | sed -e "s/^\s*[0-9]\+\s*//;s/[;&|]\s*notify$//")"'
alias mictest='arecord -vvv -f dat /dev/null'
alias pacman='sudo pacman'
alias paclogi='paclog --grep="installed|upgraded"'
alias upd='paru -Syuv'
alias sys='systemctl'

alias rm="trash"
alias mdp='mdp -sc'
alias tasks='taskwarrior-tui'
alias lswin='xwininfo -tree -root'
alias rebuildpy='pacman -Qoq /usr/lib/python3.8/ | paru -S --rebuild -'
alias mc='java -jar ~/.minecraft/TLauncher-2.79.jar'
alias dsf="diff-so-fancy"
alias bino="WGPU_BACKEND=gl binocle"
alias gist="GITHUB_GIST_TOKEN=$(pass github/gist_token) gist"

alias pkg='makechrootpkg -c -r $CHROOT'
alias pkgroot='arch-nspawn $CHROOT/orhun'
alias updcomdb='ssh repos.archlinux.org "/community/db-update"'
alias offload-build='offload-build -s build.archlinux.org ; notify'
alias offload-inspect='ssh build.archlinux.org "arch-nspawn /var/lib/archbuild/extra-x86_64/orhun"'
alias svn-diff='svn diff | dsf'
