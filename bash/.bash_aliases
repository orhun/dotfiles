alias v='vim'
alias c='xclip -selection clipboard'
alias p='xclip -o'
alias x='startx'
alias ls='exa --icons --color-scale'
alias bat='bat --theme "TwoDark"'
alias rm="rm -i"
alias cg='cargo'
alias code='vscodium'
alias bx='cp437 BitchX'
alias aur='aurpublish'
alias pkg='makechrootpkg -c -r $CHROOT'
alias pkgroot='arch-nspawn $CHROOT/orhun'
alias pacman='sudo pacman'
alias tgif='$HOME/gh/tgif/target/release/tgif' # temporary
alias mdp='mdp -sc' # temporary
alias kermitarch='kermit -c $HOME/conf/arch-theme.config' # temporary

# nvchecker wrapper for release checking
nv() {
    local cfg=$PKGBUILDS/nvchecker.ini
    local act=${1:-checker}; shift
    nv$act "$cfg" "$@"
}

# sync all AUR packages with aurpublish
syncpkgs() {
    olddir=$(pwd)
    cd $PKGBUILDS
    for d in */ ; do
        echo "==> PUSH: ${d::-1}"
        aur ${d::-1}
    done
    cd $olddir
}

# check all AUR packages with namcap
checkpkgs() {
    olddir=$(pwd)
    cd $PKGBUILDS
    for d in */ ; do
        echo "==> CHECK: ${d::-1}"
        namcap ${d::-1}/PKGBUILD
    done
    cd $olddir
}

# optimus-manager wrapper for switching GPU
optimus() {
    GPU_STATUS=$(optimus-manager --print-next-mode \
        | cut -d ':' -f 2 | tr -d ' \n')
    if [[ $GPU_STATUS != "nochange" ]] &&
    [[ ! $GPU_STATUS =~ "error" ]];
    then
        sudo prime-switch && startx
    elif [[ -z "$1" ]]; then
        optimus-manager --status
    else
        optimus-manager --switch $1 --no-confirm
    fi
}

# check coverage for a golang project
gocov () {
    t="/tmp/go-cover.$$.tmp"
    go test -coverprofile=$t $@ && go tool cover -html=$t && unlink $t
}
