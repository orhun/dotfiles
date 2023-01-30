#!/usr/bin/env bash

alias pkg='makechrootpkg -c -r $CHROOT'
alias pkgroot='arch-nspawn $CHROOT/orhun'
alias updcomdb='ssh repos.archlinux.org "/community/db-update"'
alias offload-build='offload-build -s build.archlinux.org ; notify'
alias offload-inspect='ssh build.archlinux.org "arch-nspawn /var/lib/archbuild/extra-x86_64/$USER"'
alias svn-diff='svn diff | dsf'
alias svn-last='svn log -vl 1 && svn diff -rPREV | dsf'
alias extra-x86_64-build-aurdeps='paru -U --chroot'
alias extra-x86_64-inspect='arch-nspawn "/var/lib/archbuild/extra-x86_64/$USER/"'
alias deobf-email-pkg='deobf-email $(head -1 PKGBUILD)'
