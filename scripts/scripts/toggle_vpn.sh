#!/usr/bin/env bash

status=$(systemctl is-active openvpn-client@do)
if [[ "$status" == "inactive" ]]; then
  systemctl start openvpn-client@do
  echo "UP" >/var/local/openvpn_status
else
  systemctl stop openvpn-client@do
  echo "DOWN" >/var/local/openvpn_status
fi
