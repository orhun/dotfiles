### General ###

# launch WeeChat
weechat() {
    python "$DOTFILES/weechat/.weechat/python/weenotify.py" -s &
    NOTIFIER_PID=$!
    ssh -R 5431:localhost:5431 -t alarm tmux -u -L weechat attach
    kill $NOTIFIER_PID
}

# paste files
rpaste() {
    curl -F "file=@$1" -H @/home/orhun/.rpaste_auth https://paste.orhun.dev
}

# shorten URLs
shorten() {
    curl -F "url=$1" -H @/home/orhun/.rpaste_auth https://paste.orhun.dev
}

# connect to bluetooth headset
btct () {
   bt power on
   bt connect "$BT_HEADSET"
}

# !aurctl (phrik)
aurctl() {
    git clone "https://aur.archlinux.org/$1"
}

# check updates and new releases
ups() {
    echo "==> Checking updates..."
    checkupdates
    echo "==> Checking new releases..."
    nv
    echo "==> Checking AUR updates..."
    paru -Qua
}

# https://github.com/facundoolano/rpg-cli
rpg() {
  case "${1}" in
    buy | use | battle | stat)
      rpg-cli "${@}"
      ;;
    *)
      cd "${@}" && rpg-cli cd "${PWD}"
      ;;
  esac
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

### Package Management ### 

# nvchecker wrapper for checking new releases
nv() {
    local cfg=$PKGBUILDS/nvchecker.toml
    local act=${1:-checker}; shift
    "nv$act" -c "$cfg" "$@"
}

# fetch PKGBUILD
fetchpkg() {
    curl "https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=$1" > PKGBUILD
}

# update the version in a PKGBUILD
updpkgver() {
    if [ -n "$1" ]; then
        sed "s/^pkgrel=.*\$/pkgrel=1/" -i PKGBUILD
        sed "s/^pkgver=.*\$/pkgver=$1/" -i PKGBUILD
        updpkgsums
        svn diff PKGBUILD 2>/dev/null | diff-so-fancy
        git diff PKGBUILD 2>/dev/null
    else
        pkgname=$(basename "$PWD")
        if [[ $pkgname == "trunk" ]]; then
            pkgname=$(basename $(dirname $(pwd)))
        fi
        echo "==> Found package: $pkgname"
        version=$(cat $PKGBUILDS/new_ver.json | jq -r ".\"${pkgname%-bin}\"")
        if [[ -n "$version" ]] ; then
            echo "==> New version: $version"
            updpkgver "$version"
        else
            echo "==> Cannot get version"
        fi
    fi
}

# push package to AUR
pushpkg() {
    PKG=${PWD##*/}
    git diff PKGBUILD
    git add PKGBUILD
    git commit --allow-empty-message -m "$1"
    aurpublish "$PKG" && arch-repo-release -u -p PKGBUILD && git push origin master
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
