alias v='vim'
alias ls='exa --icons --color-scale'
alias bat='bat --theme "TwoDark"'
alias rm="rm -i"
alias cg='cargo'
alias code='vscodium'
alias bx='cp437 BitchX'
alias aur='aurpublish'
alias pkg='makechrootpkg -c -r $CHROOT'

# nvchecker wrapper for release checking
nv() {
    local cfg=$HOME/.pkgbuilds/nvchecker.ini
    local act=${1:-checker}; shift
    nv$act "$cfg" "$@"
}

# push all AUR packages with aurpublish
aurpush() {
    olddir=$(pwd)
    cd $HOME/.pkgbuilds/
    for d in */ ; do
        aur ${d::-1}
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
