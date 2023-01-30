#!/usr/bin/env bash

set -eux

python "$DOTFILES/scripts/scripts/weenotify.py" -s &
NOTIFIER_PID=$!
ssh -R 5431:localhost:5431 -t alarm_remote tmux -u -L weechat attach
kill $NOTIFIER_PID
