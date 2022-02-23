#!/usr/bin/env bash

set -eux

python "$DOTFILES/weechat/.weechat/python/weenotify.py" -s &
NOTIFIER_PID=$!
ssh -R 5431:localhost:5431 -t alarm tmux -u -L weechat attach
kill $NOTIFIER_PID
