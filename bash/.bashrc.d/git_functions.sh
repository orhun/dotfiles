#!/usr/bin/env bash

# check if the current directory is a git repository
is_git_repo() {
  git rev-parse HEAD >/dev/null 2>&1
}

# git tag
gt() {
  is_git_repo || return
  git tag --sort -version:refname |
    fzf-tmux -m --preview-window top:80% \
      --preview 'git show --color=always {} | head -'$LINES
}

# git branch
gb() {
  is_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
    fzf-tmux --ansi -m --tac --preview-window top:80% \
      --header "Current branch: $(git rev-parse --abbrev-ref HEAD)" \
      --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1)' |
    sed 's/^..//' | cut -d' ' -f1 |
    sed 's#^remotes/##'
}

# git log
gl() {
  is_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
    fzf-tmux --ansi --no-sort --reverse -m \
      --preview-window top:60% \
      --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always' |
    grep -o "[a-f0-9]\{7,\}"
}

# git remote
gr() {
  is_git_repo || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
    fzf-tmux --tac --preview-window top:80% \
      --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" --remotes={1} | head -200' |
    cut -d$'\t' -f1
}

# git stash
gst() {
  is_git_repo || return
  git stash list | fzf-tmux --reverse -d: --preview 'git show --color=always {1}' |
    cut -d: -f1
}

# approve GitHub PR and merge
gh-pr-bors() {
  gh pr review "$1" --approve --body "bors r+"
}

# checkout GitHub PR
pull() {
  gh pr checkout "$1"
}

# clone a repository and cd into it
gitctl() {
  if [ -n "$2" ]; then
    git clone "$@"
    cd "${2}" || return
  else
    git clone "$1"
    cd "${1##*/}" || return
  fi
}

# named stash
git-named-stash() {
  git stash push -m "$1"
}

# dummy commit
git-dummy() {
  git commit --allow-empty --no-gpg-sign -m "$@"
}

# fetch all branches
git-fetch-branches() {
  git branch -r |
    grep -v '\->' |
    sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" |
    while read remote; do
      git branch --track "${remote#origin/}" "$remote"
    done
  git fetch --all
  git pull --all
}

# delete all branches
git-delete-branches() {
  git branch --merged | grep -v \* | xargs git branch -D
}

# vim:set ts=2 sw=2 et:
