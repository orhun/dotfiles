#!/usr/bin/env bash

set -e

REMOTE_UP_DIR="/home/ubuntu/0x0/up"
UP_DIR="$HOME/tmp/up"

mkdir -p "$UP_DIR"
scp "aws:$REMOTE_UP_DIR/*" "$UP_DIR"
ssh aws rm -f "$REMOTE_UP_DIR/*"
#find $UP_DIR -type f  ! -name "*.*" -exec mv "{}" "{}.png" \;
