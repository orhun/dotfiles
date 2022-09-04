#!/usr/bin/env bash

# credit: https://pkgbuild.com/~eschwartz/repo/x86_64/release.sh

source "$HOME/.makepkg.conf"
source /usr/share/makepkg/integrity/verify_signature.sh
source /usr/share/makepkg/util/message.sh
colorize

DO_REFRESH=0
DO_UPLOAD=0
READ_PKGBUILD=0

staging_repo="${PKGBUILDS}/.repo"
repo_name="${USER}"
build_script="PKGBUILD"
remote_repo="homedir.archlinux.org:public_html/repo"

while :; do
    case ${1} in
        -r|--refresh)
            DO_REFRESH=1
            ;;
        -u|--upload)
            DO_UPLOAD=1
            ;;
        -p|--pkgbuild)
            READ_PKGBUILD=1
            [[ -n ${2} ]] && build_script=${2} && shift
            ;;
        *)
        break
        ;;
    esac
    shift
done

pkgfiles=("${@}")

if (( READ_PKGBUILD )); then
    mapfile -t pkgfiles < <(makepkg --packagelist -p "${build_script}")
fi

if ! [[ ${PWD} -ef ${staging_repo} ]]; then
    for pkgfile in "${pkgfiles[@]}"; do
        if ! [[ -f ${pkgfile} ]]; then
            error "No built packages found for ${PWD##*/}"
            exit 1
        else
            msg "Preparing to release ${PWD##*/} to $repo_name.db"
        fi
        cp -f "${pkgfile}" "${staging_repo}"/
        [[ -f ${pkgfile}.sig ]] && cp -f "${pkgfile}.sig" "${staging_repo}"/
        msg2 "Package is moved to the staging repository."
    done
    pkgfiles=("${pkgfiles[@]##*/}")
    pushd "${staging_repo}" > /dev/null
fi

dbfiles=("$repo_name".*)

for pkgfile in "${pkgfiles[@]}"; do
    if [[ -f ${pkgfile}.sig ]]; then
        statusfile=$(mktemp)
        success=0
        gpg --quiet --batch --status-file "${statusfile}" --verify "${pkgfile}.sig" "${pkgfile}" 2>/dev/null
        parse_gpg_statusfile "${statusfile}"
        rm -f "${statusfile}"
        if (( success )); then
            msg2 "Package is already signed. Skipping."
            continue
        fi
        rm -f "${pkgfile}.sig"
        warning "Stale package signature for ${pkgfile}"
    fi
    msg2 "Signing the package."
    gpg --quiet --detach-sign --default-key "${GPGKEY}" "${pkgfile}"
done

if (( DO_REFRESH )); then
    msg "Refreshing $repo_name.db"
    scp "${dbfiles[@]/#/${remote_repo}/}" "$staging_repo"
fi

repo-add -s -v "${staging_repo}/${repo_name}.db.tar.gz" "${pkgfiles[@]}"

if (( DO_UPLOAD )); then
    msg "Uploading $repo_name.db"
    rsync --progress --partial -y -av --delay-updates --delete-delay "$staging_repo/" "${remote_repo}"
fi
