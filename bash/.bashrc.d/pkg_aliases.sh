#!/usr/bin/env bash

alias pkg='makechrootpkg -c -r $CHROOT'
alias pkgroot='arch-nspawn $CHROOT/orhun'
alias updcomdb='ssh repos.archlinux.org "/community/db-update"'
alias offload-build='offload-build -s build.archlinux.org ; notify'
alias offload-inspect='ssh build.archlinux.org "arch-nspawn /var/lib/archbuild/extra-x86_64/orhun"'
alias svn-diff='svn diff | diff-so-fancy'
