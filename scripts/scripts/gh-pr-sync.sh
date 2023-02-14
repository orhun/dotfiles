#!/usr/bin/env bash

set -eu

# repositories should be identical at the time
#SOURCE_REPO="fdehau/tui-rs"
#TARGET_REPO="tui-rs-revival/tui-rs"
# make sure you have the correct scope permissions
#GITHUB_TOKEN=""

# get the list of PRs
open_prs="$(
  curl -s -H "Authorization: Bearer ${GITHUB_TOKEN}" \
    "https://api.github.com/repos/${SOURCE_REPO}/pulls?state=open&per_page=100"
)"
readarray -t prs <<<"$(jq -r '[[.[]] | reverse[] | select(.draft ==false)][].number' <<<$open_prs)"

# switch to a temporary directory and clone target repository
cd "$(mktemp -d)" || exit
git clone "https://github.com/${TARGET_REPO}" && cd "${TARGET_REPO#*/}" || exit
git remote add source "https://github.com/${SOURCE_REPO}"

# process PRs one by one
for pr in "${prs[@]}"; do
  echo "Transferring ${pr}..."
  # get individual PR details
  pr_details=$(jq -r "[.[] | select(.number == ${pr})][0]" <<<$open_prs)
  pr_branch="${pr}/$(jq -r ".head.ref" <<<$pr_details)"
  pr_body=$(
    cat <<eof
> Upstream: [#${pr}](https://github.com/${SOURCE_REPO}/pull/${pr})

$(jq -r ".body" <<<$pr_details)
eof
  )
  # switch to the main repository and checkout PR contents
  gh repo set-default "${SOURCE_REPO}"
  gh pr checkout "${pr}"
  # create a default branch and push changes
  git branch -m "${pr_branch}"
  git push origin "${pr_branch}"
  # create a PR in the target repository
  gh repo set-default "${TARGET_REPO}"
  gh pr create \
    --repo "${TARGET_REPO}" \
    --head "${pr_branch}" \
    --title "$(jq -r ".title" <<<$pr_details)" \
    --body "${pr_body}"
  # retrieve the created PR's number
  pr_num=$(gh pr list --json number --jq .[0].number)
  # get the list of comments
  comments="$(curl -s https://api.github.com/repos/${SOURCE_REPO}/issues/${pr}/comments)"
  readarray -t comments <<<"$(
    curl -s -H "Authorization: Bearer ${GITHUB_TOKEN}" \
      https://api.github.com/repos/${SOURCE_REPO}/issues/${pr}/comments | jq '.[] | "\(.user.login) said: \(.body)"'
  )"
  # post the comments to the PR
  for comment in "${comments[@]}"; do
    if [ -n "${comment}" ]; then
      echo -e "${comment}" | sed -e 's/^"//' -e 's/"$//' | gh pr comment "${pr_num}" --body-file -
    fi
  done
done
