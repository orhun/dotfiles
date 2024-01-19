#!/usr/bin/env bash

set -e

if ! i3-msg -t get_workspaces | rg '"num":10'; then
	i3-workspace-groups-client workspace-number 10
	i3-msg 'exec alacritty -e tjournal'
else
	i3-workspace-groups-client workspace-number 10
fi
