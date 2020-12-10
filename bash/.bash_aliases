#!/usr/bin/env bash

alias v='vim'
alias c='xclip -selection clipboard'
alias p='xclip -o'
alias x='startx'
alias ls='exa --icons --color-scale'
alias ll='ls -lah'
alias bat='bat --theme "TwoDark"'
alias rm="rm -i"
alias cg='cargo'
alias ktop='bpytop'
alias code='vscodium'
alias bt='bluetoothctl'
alias xwin='xwininfo -tree -root'
alias bx='cp437 BitchX'
alias aur='aurpublish'
alias pkg='makechrootpkg -c -r $CHROOT'
alias pkgroot='arch-nspawn $CHROOT/orhun'
alias pacman='sudo pacman'
alias trizen='paru'
alias mdp='mdp -sc'
alias upd='paru -Syuv'
alias paclogr='paclog --after=`date +%F`'
alias paclogi='paclog --grep="installed|upgraded"'
alias rebuildpy='pacman -Qoq /usr/lib/python3.8/ | paru -S --rebuild -'
alias cap='menyoki -q cap --root --size $(slop -k) png save - | 0x0 - 2>/dev/null | c'
alias rec='menyoki -q rec --root --size $(slop -k) apng save - | 0x0 - 2>/dev/null | c'

# !aurctl (phrik)
aurctl() {
    git clone "https://aur.archlinux.org/$1"
}

# check updates and new releases
ups() {
    echo "==> Checking updates..."
    checkupdates
    echo "==> Checking AUR updates..."
    paru -Qua
    echo "==> Checking new releases..."
    nv "$@"
}

# nvchecker wrapper for release checking
nv() {
    local cfg=$PKGBUILDS/nvchecker.toml
    local act=${1:-checker}; shift
    "nv$act" -c "$cfg" "$@"
}

# push all AUR packages with aurpublish
pushpkgs() {
    olddir=$(pwd)
    cd "$PKGBUILDS" || exit
    for d in */ ; do
        cd "$PKGBUILDS/${d::-1}" || exit
        if ! git diff --quiet PKGBUILD;
        then
            echo "==> PUSH: ${d::-1}"
            pushpkg "$1"
        fi
        # aur ${d::-1}
    done
    cd "$olddir" || exit
}

# check all AUR packages with namcap
checkpkgs() {
    olddir=$(pwd)
    cd "$PKGBUILDS" || exit
    for d in */ ; do
        echo "==> CHECK: ${d::-1}"
        namcap "${d::-1}/PKGBUILD"
    done
    cd "$olddir" || exit
}

prunepkgs() {
    olddir=$(pwd)
    cd "$PKGBUILDS" || exit
    for d in */ ; do
        echo "==> PRUNE: ${d::-1}"
        rm -rf "${d::-1}/src"
        rm -rf "${d::-1}/pkg"
    done
    cd "$olddir" || exit
}

# update the pkgver in PKGBUILD
updpkgver() {
    if [ -n "$1" ]; then
        sed "s/^pkgrel=.*\$/pkgrel=1/" -i PKGBUILD
        sed "s/^pkgver=.*\$/pkgver=$1/" -i PKGBUILD
        updpkgsums
    fi
}

# commit a package file
cmtpkgfile() {
    git diff "$PKGBUILDS/$1*"
    git add "$PKGBUILDS/$1*"
    git commit -m "${1,,} += $2"
}

# commit package files
cmtpkgfiles() {
    olddir=$(pwd)
    cd "$PKGBUILDS" || exit
    cmtpkgfile "README" "$1"
    cmtpkgfile "nvchecker" "$1"
    cd "$olddir" || exit
}

# push package to AUR
pushpkg() {
    PKG=${PWD##*/}
    git diff PKGBUILD
    git add PKGBUILD
    git commit --allow-empty-message -m "$1"
    aur "$PKG"
}

# optimus-manager wrapper for switching GPU
optimus() {
    GPU_STATUS=$(optimus-manager --print-next-mode \
        | cut -d ':' -f 2 | tr -d ' \n')
    if [[ $GPU_STATUS != "nochange" ]] &&
    [[ ! $GPU_STATUS =~ "error" ]];
    then
        sudo prime-switch && startx
    elif [[ -z "$1" ]]; then
        optimus-manager --status
    else
        optimus-manager --switch "$1" --no-confirm
    fi
}

# check coverage for a golang project
gocov () {
    t="/tmp/go-cover.$$.tmp"
    go test -coverprofile=$t "$@" && go tool cover -html=$t && unlink $t
}
