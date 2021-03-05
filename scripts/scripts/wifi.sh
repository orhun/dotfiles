#!/bin/env bash

# This is a brief summary of connecting to a WPA/WPA2 WiFi network
# https://linuxcommando.blogspot.com/2013/10/how-to-connect-to-wpawpa2-wifi-network.html

# Find out the wireless device name.
# iw dev
dev=$(ip -br link | grep wlan | awk '{ print $1 }')

# Check if the device is up.
# ip link set interface up
ip link set $dev up
#ip link set wlp3s0 up

# Check connection status.
# iw interface link

# Scan networks.
# sudo iw interface scan | less

# Connect to WPA/WPA2 WiFi network.
# wpa_passphrase SSID >> /etc/wpa_supplicant.conf
# wpa_supplicant -B -D wext -i interface -c /etc/wpa_supplicant.conf -f /var/log/wpa_supplicant.log -t -d
wpa_supplicant -B -D wext -i $dev -c /etc/wpa_supplicant.conf -f /var/log/wpa_supplicant.log -t -d
#wpa_supplicant -B -D wext -i wlp3s0 -c /etc/wpa_supplicant.conf -f /var/log/wpa_supplicant.log -t -d
# dhcpcd
dhcpcd
