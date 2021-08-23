### General ###

# launch WeeChat
weechat() {
    python "$DOTFILES/weechat/.weechat/python/weenotify.py" -s &
    NOTIFIER_PID=$!
    ssh -R 5431:localhost:5431 -t archbox tmux attach-session -t weechat
    kill $NOTIFIER_PID
}

# paste files
rpaste() {
    curl -F "file=@$1" -H @/home/orhun/.rpaste_auth https://paste.orhun.dev
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
    echo "==> Checking AUR updates..."
    paru -Qua
}
