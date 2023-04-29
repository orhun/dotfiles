#!/usr/bin/env bash

# notify about the status of last command
notify() {
  status=$([ $? -eq 0 ] && echo "Completed" || echo "Failed")
  last_cmd=$(fc -nl -1 | xargs | sed -e "s/;\s*notify$//")
  notify-send --urgency=normal "$status: $last_cmd"
  gotify push -t "$status" "$last_cmd" >/dev/null
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
cgrun() { (
  set -e
  if [ -n "$1" ]; then
    metadata=$(cargo metadata --no-deps --format-version 1)
    target_dir=$(jq -r '.target_directory' <<<"$metadata")
    workspace_root=$(jq -r '.workspace_root' <<<"$metadata")
    binary=$(basename "$workspace_root")
    "$target_dir/$1/$binary" "${@:2}"
  fi
); }

# github gist client
gist() {
  GITHUB_GIST_TOKEN=$(pass github/gist_token) "$HOME/.cargo/bin/gist" $@
}

# https://patorjk.com/software/taag/
taag() {
  if [ -n "$1" ]; then
    find /usr/share/figlet/ -type f -name "*.flf" -exec basename {} \; |
      xargs -I {} sh -c "printf '\n\n{}\n\n' && figlet $1 -f '{}'"
  fi
}

# find the total size to delete in workspace
cleanup-workspace-find-size() {
  find "$WORKSPACE/" -maxdepth 2 -type d -name target -exec du -ch {} + | grep total$
}

# clean up the workspace
cleanup-workspace() {
  find "$WORKSPACE/" -maxdepth 2 -type d -name target -exec /usr/bin/rm -vr "{}" \;
}

# file explorer
tere() {
  local result=$(command tere -m alt-enter:Exit "$@")
  [ -n "$result" ] && cd -- "$result"
}

# deobfuscate email
deobf-email() {
  # pick all arguments as one string
  args="$*"
  # remove everything before <
  mail="${args#*<}"
  # remove everything after >
  mail="${mail%>*}"
  # (at) -> @
  mail="${mail//(at)/@}"
  # (dot) -> .
  mail="${mail//(dot)/.}"
  # at -> @
  mail="${mail// at /@}"
  # dot -> .
  mail="${mail// dot /.}"
  # remove remaining spaces an echo mail
  echo "${mail//[[:space:]]/}"
}

# http://cheat.sh
cheat() {
  curl "cheat.sh/$1"
}

# decode JWT token
decode-jwt() {
  jq -R 'split(".") | .[0],.[1] | @base64d | fromjson' <<<"${1}"
}

# scan the network
net-scan() {
  nmap -v "$(ip -o -f inet addr show | awk '/wlp/ {print $4}')"
}

# trick the command into thinking its stdout is a terminal, not a pipe
fake-tty() {
  script -qfc "$(printf "%q " "$@")" /dev/null
}

# grep binary properties
rgbin() {
  color='\033[1;32m'
  nc='\033[0m'
  echo -e "${color}GLIBC versions used:${nc}"
  objdump -T "$1" | rg GLIBC | sed 's/.*GLIBC_\([.0-9]*\).*/\1/g' | sort -Vu
  echo -e "${color}RELRO:${nc}"
  readelf -a "$1" | rg GNU_RELRO | sed 's/  */ /g'
  echo -e "${color}Binary type:${nc}"
  readelf -a "$1" | rg "Type:" | sed 's/  */ /g'
}

# download MP3 from YouTube
yt-mp3() {
  yt-dlp -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 "$1"
}

# copy image to clipboard
cp-img() {
  xclip -selection clipboard -t image/png -i "$1"
}

# run in a clean env
clean-exec() {
  exec env -i \
    _CLEAN=1 \
    HOME="$HOME" \
    PATH="$PATH" \
    USER="$USER" \
    TERM="xterm" \
    ${ENV_YOU_KEEP:+ENV_YOU_KEEP="$ENV_YOU_KEEP"} \
    "$0" "$@"
}

# vim:set ts=2 sw=2 et:
