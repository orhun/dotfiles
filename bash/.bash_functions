#!/usr/bin/env bash

# launch WeeChat
weechat() {
    python "$DOTFILES/weechat/.weechat/python/weenotify.py" -s &
    NOTIFIER_PID=$!
    ssh -R 5431:localhost:5431 -t alarm tmux -u -L weechat attach
    kill $NOTIFIER_PID
}

# connect to bluetooth headset
btct () {
   bt << EOF
select "$BT_CONTROLLER"
power on
connect "$BT_HEADSET"
EOF
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

# run the already built rust binary
cgrun() {( set -e
    if [ -n "$1" ]; then
        metadata=$(cargo metadata --no-deps --format-version 1)
        target_dir=$(jq -r '.target_directory' <<< "$metadata")
        workspace_root=$(jq -r '.workspace_root' <<< "$metadata")
        binary=$(basename "$workspace_root")
        "$target_dir/$1/$binary" "${@:2}"
    fi
)}

# github gist client
gist() {
    GITHUB_GIST_TOKEN=$(pass github/gist_token) "$HOME/.cargo/bin/gist" $@
}

# file explorer
cdj() {
    selected=$(xplr)
    if [[ -d $selected ]]; then
        cd "$selected"
    else
        cd "$(dirname $selected)"
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
