#!/usr/bin/env bash
#
# Emoji Menu
#
# Quickly find emojis and copy to clipboard.
#
# https://github.com/jchook/emoji-menu

set -e

# Emoji database location
EMOJI_MENU_DB=${EMOJI_MENU_DB:-"$HOME/.emoji-menu-db"}

# Command to run after user chooses an emoji
EMOJI_MENU_COMMAND=${EMOJI_MENU_COMMAND:-'xclip -selection clipboard'}

# Report usage
usage() {
  echo "Usage: $(basename "$0") [-t | -c <command>] [-f <filepath> ]" 1>&2
  echo
  echo "   -f <filepath>  Use a custom emoji database."
  echo "   -c <command>   Apply a custom command to the emoji choice."
  echo "   -t             Simulate typing the emoji choice with the keyboard."
  echo
  exit "$1"
}

# Type result using xdotool
typeResult() {
  awk '{ print "type " $0 }' | xdotool -
}

# Get Options
while getopts ":c:f:th" o; do
  case "${o}" in
  f) EMOJI_MENU_DB="${OPTARG}" ;;
  c) EMOJI_MENU_COMMAND="${OPTARG}" ;;
  t) EMOJI_MENU_COMMAND=typeResult ;;
  h) usage 0 ;;
  *) usage 1 ;;
  esac
done

# Default DB
if [ ! -e "$EMOJI_MENU_DB" ]; then
  wget -O "$EMOJI_MENU_DB" 'https://raw.githubusercontent.com/jchook/emoji-menu/master/data/emojis.txt'
fi

# Rofi can handle large inputs and emojis
rofi -p '🔍' -width 610 -dmenu \
  <"$EMOJI_MENU_DB" |
  grep -oP '^[^\s]+' |
  tr -d '\n' |
  ${EMOJI_MENU_COMMAND}
