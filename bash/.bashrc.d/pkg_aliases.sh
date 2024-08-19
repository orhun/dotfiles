#!/usr/bin/env bash

alias pkg='makechrootpkg -c -r $CHROOT'
alias pkgroot='arch-nspawn $CHROOT/orhun'
alias offload-build='offload-build -s build.archlinux.org ; notify'
alias pkg-build='pkgctl build -o; notify'
alias offload-inspect='ssh build.archlinux.org "arch-nspawn /var/lib/archbuild/extra-x86_64/$USER"'
alias extra-x86_64-build-aurdeps='paru -U --chroot'
alias extra-x86_64-inspect='arch-nspawn "/var/lib/archbuild/extra-x86_64/$USER/"'
alias deobf-email-pkg='deobf-email $(head -1 PKGBUILD)'
alias alp='alpine-chroot'
alias pkg-diff='git diff *BUILD'
alias update-srcinfo='makepkg --printsrcinfo > .SRCINFO'
