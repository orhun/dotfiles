#!/usr/bin/env bash

set -e

if ! i3-msg -t get_workspaces | rg '"num":6'; then
  i3-msg 'workspace 6'
  i3-msg 'exec alacritty -e bpytop' && sleep 1
  i3-msg 'split v; exec alacritty -e journalctl -fex' && sleep 1
  i3-msg 'resize shrink up 150'
  i3-msg 'split h; exec alacritty -e dmesg -w --color=never' && sleep 1
else
  i3-msg 'workspace 6'
fi
