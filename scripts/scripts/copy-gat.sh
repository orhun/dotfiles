#!/usr/bin/env bash

PINENTRY_USER_DATA=qt /usr/bin/pass -c gat
notify-send "copied to clipboard!" -a "pass" -t 1000
