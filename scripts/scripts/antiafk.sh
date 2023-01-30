#!/usr/bin/env bash

set -e

randomchar() {
  openssl rand -base64 1 | cut -c1-1
}

while true; do
  for i in {1..20}; do
    xdotool type $(randomchar)
    sleep 0.3s
  done

  for i in {1..20}; do
    xdotool key BackSpace
    sleep 0.1s
  done
done
