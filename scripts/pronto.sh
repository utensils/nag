#!/bin/bash
# This script is a simple wrapper around Pronto

DEFAULT_BRANCH='origin/master'

BRANCH=${MASTER_BRANCH:-$DEFAULT_BRANCH}
GIT_URL=https://$GITHUB_ACCESS_TOKEN@github.com/$REPO
REPO_DIR="${REPO/\//_}#${PULL_REQUEST_ID}"

git clone $GIT_URL $REPO_DIR \
  && cd $REPO_DIR \
  && git checkout $WORKING_BRANCH \
  && GITHUB_SLUG=$REPO \
     GITHUB_ACCESS_TOKEN=$GITHUB_ACCESS_TOKEN \
     PULL_REQUEST_ID=$PULL_REQUEST_ID \
     bundle exec pronto run -f github_pr -c $BRANCH

# Clean-up
cd .. && rm -rf "${REPO_DIR}"
