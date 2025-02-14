#!/usr/bin/env bash

# !aurctl (phrik)
aurctl() {
  git clone "https://aur.archlinux.org/$1"
  cd "$1" || exit
}

# check updates and new releases
ups() {
  echo "==> Checking updates..."
  checkupdates
  echo "==> Checking new releases..."
  nv
  echo "==> Checking AUR updates..."
  paru -Qua
}

# nvchecker wrapper for checking new releases
nv() {
  local cfg=$AUR_PKGS/nvchecker.toml
  local act=${1:-checker}
  shift
  if [ "$act" = "open" ] || [ "$act" = "o" ]; then
    pkg="$1"
    if [ -z "$pkg" ]; then
      pkg=$(basename "$PWD")
    fi
    repo=$(rg -i -N -A 5 "\[$pkg\]" "$AUR_PKGS/nvchecker.toml" | rg 'github =' | cut -d \" -f2)
    if [ -n "$repo" ]; then
      gh release view -R "$repo"
      handlr open "https://github.com/$repo/releases"
    else
      echo "==> Unknown repository."
    fi
  else
    "nv$act" -c "$cfg" "$@"
  fi
}

# fetch PKGBUILD from the AUR
fetchpkg() {
  curl "https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=$1" >PKGBUILD
}

# fetch PKGBUILD from the official repositories
pkgup() {
  pkgctl repo clone "$1"
}

# update the version and checksums of a package
updpkg() {
  pkg="$1"
  if [ -z "$pkg" ]; then
    pkg=$(jq -r 'keys[]' <"$AUR_PKGS/new_ver.json" | fzf --height 20%)
  fi
  if [[ ! -z "$pkg" ]]; then
    version=$(jq -r ".\"${pkg%-bin}\"" <"$AUR_PKGS/new_ver.json")
    if [[ -n "$version" ]]; then
      pkg_dir="$AUR_PKGS/$pkg"
      if [[ -n $(find "$EXTRA_PKGS" -type d -name "$pkg" 2>/dev/null) ]]; then
        echo "==> Found in official repositories"
        pkg_dir="$EXTRA_PKGS/$pkg"
      else
        echo "==> Found in the AUR"
      fi
      cd "$pkg_dir" || return
      updpkgver
      read -r -p "==> Press enter to build package..." -r
      offload-build
    else
      echo "==> Cannot get version"
    fi
  fi
}

# update the version in a PKGBUILD/APKBUILD
updpkgver() {
  pkgname=$(basename "$PWD")
  if [ -n "$1" ]; then
    if [ -f PKGBUILD ]; then
      git pull >/dev/null
      sed "s/^pkgrel=.*\$/pkgrel=1/" -i PKGBUILD
      sed "s/^pkgver=.*\$/pkgver=$1/" -i PKGBUILD
      updpkgsums
      git diff PKGBUILD 2>/dev/null
    elif [ -f APKBUILD ]; then
      sed "s/^pkgrel=.*\$/pkgrel=0/" -i APKBUILD
      sed "s/^pkgver=.*\$/pkgver=$1/" -i APKBUILD
      alpine-chroot bash -c "cd $pkgname && abuild checksum"
      git diff APKBUILD 2>/dev/null
      git add APKBUILD
      git commit
      git push --force
    fi
  else
    echo "==> Found package: $pkgname"
    version=$(jq -r ".data.\"${pkgname%-bin}\".version" <"$AUR_PKGS/new_ver.json")
    if [[ -n "$version" ]]; then
      echo "==> New version: $version"
      updpkgver "$version"
      nv o
    else
      echo "==> Cannot get version"
    fi
  fi
}

# update the Cargo.lock for a Rust package
updpkglock() {
  oldpwd="$(pwd)"
  pkgname=$(basename "$oldpwd")
  version=$(jq -r ".data.\"${pkgname%-bin}\".version" <"$AUR_PKGS/new_ver.json")
  repo=$(rg -i -N -A 5 "\[$pkgname\]" "$AUR_PKGS/nvchecker.toml" | rg 'github =' | cut -d \" -f2)
  echo "==> Generating Cargo.lock for $pkgname:$version ($repo)"
  cdtmp
  gitctl "https://github.com/$repo"
  git checkout "$version" 2>/dev/null
  git checkout "v$version" 2>/dev/null
  cargo generate-lockfile
  cp Cargo.lock "$oldpwd"
  cd "$oldpwd"
  updpkgsums
}

# update the last commit
updpkgcommit() {
  oldpwd="$(pwd)"
  pkgname=$(basename "$oldpwd")
  version=$(jq -r ".data.\"${pkgname%-bin}\".version" <"$AUR_PKGS/new_ver.json")
  repo=$(rg -i -N -A 5 "\[$pkgname\]" "$AUR_PKGS/nvchecker.toml" | rg 'github =' | cut -d \" -f2)
  echo "==> Fetching the last commit for $pkgname:$version ($repo)"
  cdtmp
  gitctl "https://github.com/$repo"
  git checkout "$version" 2>/dev/null
  git checkout "v$version" 2>/dev/null
  commit=$(git rev-parse HEAD)
  cd "$oldpwd"
  for var in '_commit' '_tag' '_gitcommit'; do
    sed -i "s|\(^$var\)=.*$|\1=$commit|g" PKGBUILD
  done
  git diff PKGBUILD
}

# publish a package to the official repositories
releasepkg() {
  commit_msg="upstream release"
  if [ -n "$1" ]; then
    commit_msg="$1"
  fi
  (
    set -e
    pkgname=$(basename $(pwd))
    echo "==> Found package: $pkgname"
    git diff
    pkgctl release --db-update --message "$commit_msg"
    nv take "$pkgname" 2>/dev/null
  )
}

# push package to the AUR
pushpkg() {
  LOCKFILE="${AUR_PKGS}/pkg.lock"
  while [ -e "${LOCKFILE}" ] && kill -0 $(cat ${LOCKFILE}); do
    echo "==> Waiting for the lock"
    sleep 5
  done
  trap "rm -f ${LOCKFILE}; exit" INT TERM EXIT
  echo $$ >"${LOCKFILE}"

  echo "==> Publishing the AUR package"
  PKG=${PWD##*/}
  git --no-pager diff PKGBUILD
  git add PKGBUILD
  git commit --allow-empty-message -m "$1"
  aurpublish "$PKG" &&
    "$AUR_PKGS/arch-repo-release.sh" -u -p PKGBUILD &&
    git push origin master

  rm -f "${LOCKFILE}"
  echo "==> Done publishing '$PKG'"
}

# create a new package
newpkg() {
  if [ -n "$1" ]; then
    cd "$EXTRA_PKGS" || exit
    pkgctl repo create --clone "$1"
    cd "$1" || exit
    cp /usr/share/pacman/PKGBUILD.proto PKGBUILD
  fi
}

# commit the new package
commitnewpkg() {
  if [ -n "$1" ]; then
    cd "$EXTRA_PKGS/$1" || exit
    git add PKGBUILD
    PKGVER=$(grep -Eo "^pkgver=.*\$" <PKGBUILD | cut -d '=' -f2)
    PKGREL=$(grep -Eo "^pkgrel=.*\$" <PKGBUILD | cut -d '=' -f2)
    PKG="$1 $PKGVER-$PKGREL"
    read -r -p "==> Commit new package: '$PKG'? [Y/n] "
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      printf "\n==> Committing package...\n"
      git commit -m "addpkg: $PKG"
    else
      printf "\n==> Bail.\n"
    fi
  else
    echo "==> Tell me the package."
  fi
}

# install the built package
installpkg() {
  pkgname=$(basename "$PWD")
  version=$(jq -r ".data.\"${pkgname%-bin}\".version" <"$AUR_PKGS/new_ver.json")
  if [[ -n "$version" ]]; then
    pacman --noconfirm -U "$pkgname"-"$version"-*.tar.zst
    halp "$pkgname"
  fi
}

# chroot into Alpine container
alpine-chroot() {
  if ! grep -qs "$ALPINE_CHROOT/proc" /proc/mounts; then
    sudo mount -n --bind /proc "$ALPINE_CHROOT/proc"
  fi
  if ! grep -qs "$ALPINE_CHROOT/aports" /proc/mounts; then
    sudo mount --bind "$APORTS" "$ALPINE_CHROOT/aports"
  fi
  sudo "$ALPINE_CHROOT/enter-chroot" -u "$USER" "$@"
}

# checkout to the package
alpine-checkout() {
  if [ -n "$1" ]; then
    cd "$APORTS"
    git checkout master
    git pull
    git branch -D "aport/$1" 2>/dev/null
    git checkout -b "aport/$1"
    cd "testing/$1" || cd "community/$1" || mkdir "testing/$1" || exit
    rm "$APKBUILDS/$1" 2>/dev/null
    mkdir "$APKBUILDS/$1"
    repo="$(basename $(dirname $PWD))"
    ln -s "/aports/$repo/$1/APKBUILD" "$APKBUILDS/$1/APKBUILD" 2>/dev/null
  fi
}

# taken from
# <https://gitlab.archlinux.org/pacman/pacman/-/blob/a2d029388c7c206f5576456f91bfbea2dca98c96/scripts/repo-add.sh.in#L374-387>
elephant() {
  case $((RANDOM % 2)) in
  0)
    printf '%s\n' "H4sIAL3qBE4CAyWLwQ3AMAgD/0xh5UPzYiFUMgjq7LUJsk7yIQNAQTAikFUDnqkr" \
      "OQFOUm0Wd9pHCi13ONjBpVdqcWx+EdXVX4vXvGv5cgztB9+fJxZ7AAAA"
    ;;

  1)
    printf '%s\n' "H4sIAJVWBU4CA21RMQ7DIBDbeYWrDgQJ7rZ+IA/IB05l69alcx5fc0ASVXUk4jOO" \
      "7yAAUWtorygwJ4hlMii0YkJKKRKGvsMsiykl1SalvrMD1gUXyXRkGZPx5OPft81K" \
      "tNAiAjyGjYO47h1JjizPkJrCWbK/4C+uLkT7bzpGc7CT9bmOzNSW5WLSO5vexjmH" \
      "ZL9JFFZeAa0a2+lKjL2anpYfV+0Zx9LJ+/MC8nRayuDlSNy2rfAPibOzsiWHL0jL" \
      "SsjFAQAA"
    ;;
  esac | base64 -d | gzip -d
}

# vim:set ts=2 sw=2 et:
