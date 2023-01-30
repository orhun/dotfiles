#!/usr/bin/env bash

set -e

case "$PINENTRY_USER_DATA" in
qt)
  exec /usr/bin/pinentry-qt "$@"
  ;;
*)
  exec /usr/bin/pinentry-curses "$@"
  ;;
esac
