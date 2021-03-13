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
alias lswin='xwininfo -tree -root'
alias pkg='makechrootpkg -c -r $CHROOT'
alias pkgroot='arch-nspawn $CHROOT/orhun'
alias pacman='sudo pacman'
alias aur='paru'
alias mdp='mdp -sc'
alias upd='paru -Syuv'
alias paclogr='paclog --after=`date +%F`'
alias paclogi='paclog --grep="installed|upgraded"'
alias rebuildpy='pacman -Qoq /usr/lib/python3.8/ | paru -S --rebuild -'
alias cap='menyoki -q cap --root --size $(slop -k) png save - | 0x0 - 2>/dev/null | c'
alias rec='menyoki -q rec --root --size $(slop -k) gif --gifski save - | 0x0 - 2>/dev/null | c'
alias updcomdb='ssh repos.archlinux.org "/community/db-update"'
alias offload-build='offload-build -s build.archlinux.org'
alias tasks='taskwarrior-tui'
alias notify='notify-send --urgency=normal "Task $([ $? -eq 0 ] && echo "completed" || echo "failed"): $(history | tail -n1 | sed -e "s/^\s*[0-9]\+\s*//;s/[;&|]\s*notify$//")"'
alias mictest='arecord -vvv -f dat /dev/null'

# !aurctl (phrik)
aurctl() {
    git clone "https://aur.archlinux.org/$1"
}

# fetch PKGBUILD
fetchpkg() {
    curl "https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=$1" > PKGBUILD
}

# check updates and new releases
ups() {
    echo "==> Checking updates..."
    checkupdates
    echo "==> Checking new releases..."
    nv "$@"
    echo "==> Checking AUR updates..."
    paru -Qua
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
        if ! git diff --quiet PKGBUILD; then
            echo "==> PUSH: ${d::-1}"
            pushpkg "$1"
        else
            echo "==> SKIP: ${d::-1}"
        fi
        # aurpublish ${d::-1}
    done
    cd "$olddir" || exit
}

# check all AUR packages with namcap
checkpkgs() {
    olddir=$(pwd)
    cd "$PKGBUILDS" || exit
    for d in */ ; do
        cd ${d::-1}
        echo "==> CHECK: ${d::-1}"
        namcap "${d::-1}/PKGBUILD"
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

# push package to AUR
pushpkg() {
    PKG=${PWD##*/}
    git diff PKGBUILD
    git add PKGBUILD
    git commit --allow-empty-message -m "$1"
    aurpublish "$PKG" && arch-repo-release -u -p PKGBUILD
}

# create a new package directory in SVN
newpkg() {
    if [ -n "$1" ]; then
        cd "$PKGS" || exit
        mkdir -p "$1"/{repos,trunk}
        cd "$1/trunk" || exit
        cp /usr/share/pacman/PKGBUILD.proto PKGBUILD
    fi
}

# commit the new package into SVN
commitnewpkg() {
    if [ -n "$1" ]; then
        cd "$PKGS/$1" || exit
        svn add --parents repos trunk/PKGBUILD
        PKGVER=$(grep -Eo "^pkgver=.*\$" < trunk/PKGBUILD | cut -d '=' -f2)
        PKGREL=$(grep -Eo "^pkgrel=.*\$" < trunk/PKGBUILD | cut -d '=' -f2)
        PKG="$1 $PKGVER-$PKGREL"
        read -p "==> Commit new package: '$PKG'? [Y/n] " -r
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
            printf "\n==> Committing package...\n"
            svn commit -m "addpkg: $PKG"
        else
            printf "\n==> Bail.\n"
        fi
	    cd "trunk" || exit
    else
        echo "==> Tell me the package."
    fi
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
