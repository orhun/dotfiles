#!/usr/bin/env bash

devices=$(bluetoothctl devices Paired | cut -f 2- -d ' ')

options=()
while read -r n s; do
  options+=("$n" "$s")
done <<<"$devices"

device=$(dialog --clear \
  --backtitle "BT Select" \
  --title "Bluetooth" \
  --menu "Select the device to connect:" \
  15 50 4 \
  "${options[@]}" \
  2>&1 >/dev/tty)

bluetoothctl power on
bluetoothctl connect "$device"
