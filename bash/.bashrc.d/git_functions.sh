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

# git status
gs() {
  is_git_repo || return
  git -c color.status=always status --short |
    fzf-tmux -m --preview-window top:80% --ansi --nth 2..,.. \
      --preview 'git diff -- {-1} | diff-so-fancy'
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

# clone a repository and cd into it
gitctl() {
  git clone "$1"
  cd "${1##*/}" || exit
}

# vim:set ts=2 sw=2 et:
