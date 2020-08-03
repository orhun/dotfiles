#!/bin/bash

# Mirrors the first screen to an HDMI screen.
xrandr --fb 1920x1080 --output eDP1 --mode 1366x768 --scale-from 1920x1080 --output HDMI1 --mode 1920x1080 --scale 1x1 --same-as eDP1
