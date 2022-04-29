### General ###

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
    echo "==> Checking AUR updates..."
    paru -Qua
}

# cd into a temporary directory
cdtmp() {
   cd $(mktemp -d)
}

