#!/usr/bin/env bash
#
# System info

wm="$(wmctrl -m | grep Name: | cut -d ' ' -f2)"
distro="$(cat /etc/*-release | grep PRETTY_NAME | cut -d '=' -f2 | tr -d '"')"
packages="$(pacman -Qq | wc -l)"
font="Monospace"
colors="Lilac"

printf " \e[0m\n"
printf " \e[1;34m      distro \e[0m$distro\n"
printf " \e[1;34m    packages \e[0m$packages\n"
printf " \e[1;34m          wm \e[0m$wm\n"
printf " \e[1;34m        font \e[0m$font $fontsize\n"
printf " \e[1;34m      colors \e[0m$colors\n"
printf " \e[0m\n"

pcs() { for i in {0..7}; do echo -en "\e[${1}$((30 + $i))m \u2588\u2588 \e[0m"; done; }
printf "\n%s\n%s\n\n" "$(pcs)" "$(pcs '1;')"
