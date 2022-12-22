#!/usr/bin/env bash

selection=$(slop -k)
menyoki -q cap --root --size "$selection" png save - | rpaste - 2>/dev/null | xclip -selection clipboard
notify-send "copied to clipboard!" -a "screenshot" -t 1000
