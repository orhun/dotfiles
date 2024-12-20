#!/usr/bin/env bash

alias god='git status && git-repl'
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
