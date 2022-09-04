#!/usr/bin/env bash

# notify about the status of last command
notify() {
    status=$([ $? -eq 0 ] && echo "Completed" || echo "Failed")
    last_cmd=$(fc -nl -1 | xargs | sed -e "s/;\s*notify$//")
    notify-send --urgency=normal "$status: $last_cmd"
    gotify push -t "$status" "$last_cmd" > /dev/null
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

# switch to a temporary directory
cdtmp() {
    cd $(mktemp -d)
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

# https://patorjk.com/software/taag/
taag() {
    find /usr/share/figlet/ -type f -name "*.flf" -exec basename {} \; | \
	    xargs -I {} sh -c "printf '\n\n{}\n\n' && figlet '$1' -f {}"
}

