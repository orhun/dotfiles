#!/usr/bin/env bash

set -e

if ! i3-msg -t get_workspaces | rg '"num":6'; then
	i3-workspace-groups-client workspace-number 6
	i3-msg 'exec alacritty -e zellij --layout monitoring'
else
	i3-workspace-groups-client workspace-number 6
fi
