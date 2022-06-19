#!/usr/bin/env bash

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
  local cfg=$PKGBUILDS/nvchecker.toml
  local act=${1:-checker}
  shift
  if [ "$act" = "open" ] || [ "$act" = "o" ]; then
    pkg="$1"
    if [ -z "$pkg" ]; then
      pkg=$(basename "$PWD")
      if [[ $pkg == "trunk" ]]; then
        pkg=$(basename $(dirname $(pwd)))
      fi
    fi
    repo=$(rg -i "github = \".*/$pkg\"" "$PKGBUILDS/nvchecker.toml" | awk '{ print $NF }' | tr -d '"')
    if [ ! -z "$repo" ]; then
      gh release view -R "$repo"
      xdg-open "https://github.com/$repo/releases"
    else
      echo "==> Unknown repository."
    fi
  else
    "nv$act" -c "$cfg" "$@"
  fi
}

# fetch PKGBUILD
fetchpkg() {
  curl "https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=$1" >PKGBUILD
}

# update the version and checksums of a package
updpkg() {
  pkg="$1"
  if [ -z "$pkg" ]; then
    pkg=$(jq -r 'keys[]' <"$PKGBUILDS/new_ver.json" | fzf --height 20%)
  fi
  if [[ ! -z "$pkg" ]]; then
    version=$(jq -r ".\"${pkg%-bin}\"" <"$PKGBUILDS/new_ver.json")
    if [[ -n "$version" ]]; then
      pkg_dir="$PKGBUILDS/$pkg"
      if [[ -n $(find "$PKGS" -type d -name "$pkg" 2>/dev/null) ]]; then
        echo "==> Found in [community]"
        pkg_dir="$PKGS/$pkg/trunk"
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

# update the version in a PKGBUILD
updpkgver() {
  if [ -n "$1" ]; then
    sed "s/^pkgrel=.*\$/pkgrel=1/" -i PKGBUILD
    sed "s/^pkgver=.*\$/pkgver=$1/" -i PKGBUILD
    updpkgsums
    svn diff PKGBUILD 2>/dev/null | diff-so-fancy
    git diff PKGBUILD 2>/dev/null
  else
    pkgname=$(basename "$PWD")
    if [[ $pkgname == "trunk" ]]; then
      pkgname=$(basename $(dirname $(pwd)))
    fi
    echo "==> Found package: $pkgname"
    version=$(jq -r ".\"${pkgname%-bin}\"" <"$PKGBUILDS/new_ver.json")
    if [[ -n "$version" ]]; then
      echo "==> New version: $version"
      updpkgver "$version"
    else
      echo "==> Cannot get version"
    fi
  fi
}

# publish a package to the [community]
community-updpkg() { (
  set -e
  pkgname=$(basename $(dirname $(pwd)))
  echo "==> Found package: $pkgname"
  svn-diff
  communitypkg "upstream release"
  updcomdb
  nv take "$pkgname"
); }

# push package to the AUR
pushpkg() {
  LOCKFILE="${PKGBUILDS}/pkg.lock"
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
  aurpublish "$PKG" && arch-repo-release -u -p PKGBUILD && git push origin master

  rm -f "${LOCKFILE}"
  echo "==> Done publishing '$PKG'"
}

# create a new package directory in SVN
newpkg() {
  if [ -n "$1" ]; then
    cd "$PKGS" || exit
    mkdir -p "$1"/{repos,trunk}
    cd "$1/trunk" || exit
    cp /usr/share/pacman/PKGBUILD.proto PKGBUILD
  fi
}

# commit the new package into SVN
commitnewpkg() {
  if [ -n "$1" ]; then
    cd "$PKGS/$1" || exit
    svn add --parents repos trunk/PKGBUILD
    PKGVER=$(grep -Eo "^pkgver=.*\$" <trunk/PKGBUILD | cut -d '=' -f2)
    PKGREL=$(grep -Eo "^pkgrel=.*\$" <trunk/PKGBUILD | cut -d '=' -f2)
    PKG="$1 $PKGVER-$PKGREL"
    read -r -p "==> Commit new package: '$PKG'? [Y/n] "
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      printf "\n==> Committing package...\n"
      svn commit -m "addpkg: $PKG"
    else
      printf "\n==> Bail.\n"
    fi
    cd "trunk" || exit
  else
    echo "==> Tell me the package."
  fi
}

# vim:set ts=2 sw=2 et: