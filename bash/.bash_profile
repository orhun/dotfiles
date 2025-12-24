#!/usr/bin/env bash

[[ -f ~/.bashrc ]] && . ~/.bashrc

export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
[[ -f /home/orhun/.nix-profile/etc/profile.d/nix.sh ]] && source /home/orhun/.nix-profile/etc/profile.d/nix.sh
