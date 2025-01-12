#!/usr/bin/env bash

alias gco='git checkout $(gb)'
alias gtv='git tag -v $(gt)'
alias gpp='git pull $(gr) $(gb)'
alias gps='git push $(gr) $(gb)'
alias gcpy='git rev-parse $(gl) | c'
alias gups='git config --get remote.origin.url | sed -E "s|.*github.com/||g" | xargs -I '{}' curl -s "https://api.github.com/repos/{}" | jq -r '.source.clone_url''
alias git-addups='git remote add base "$(gups)"'
alias ghpr='gh pr create'
alias prls='gh pr ls'
alias ghrun='gh run watch $(gh run list -L 1 --json databaseId -q '.[].databaseId') --exit-status -i 1 ; notify'
alias ghfetch='gh userfetch'
alias starfield='gh screensaver -s starfield'
alias lgtm='gh lgtmoon'
alias gsubmod='GIT_TRACE=1 GIT_CURL_VERBOSE=1 git submodule update --init --recursive --progress'
alias git-signall="git rebase --signoff main && git push --force-with-lease"

alias d="git d"
alias st="git st"
alias dc="git dc"
alias br="git br -v"
alias rmt="git rmt"
alias rs="git rs"
alias rst="git rst"
alias s="git show"
alias aa="git add -A"
alias a="git add"
alias cmt="git cmt"
alias cmta="git cmta"
alias new="git new"
alias commit="git commit"
alias rebase="git rebase"
alias gps="git push"
alias gs="git -c diff.external=difft show --ext-diff"
alias glog="git -c diff.external=difft log -p --ext-diff"
alias ndiff="git diff --no-ext-diff"
alias cont="git rebase --continue"
