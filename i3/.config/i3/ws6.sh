#!/usr/bin/env bash

set -e

if ! i3-msg -t get_workspaces | rg '"num":6'; then
  i3-msg 'workspace 6'
  i3-msg 'exec kermit -e "bpytop"' && sleep 2
  i3-msg 'split v; exec kermit -e "journalctl -fex"' && sleep 2
  i3-msg 'resize shrink up 150'
  i3-msg 'exec kermit -e "dmesg -w"' && sleep 2
else
  i3-msg 'workspace 6'
fi

