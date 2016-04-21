#!/bin/bash
# This script is a simple wrapper around Pronto for our Docker container 

DEFAULT_BRANCH='origin/master'

export PATH=$(ruby -rubygems -e 'puts Gem.user_dir')/bin:$PATH

BRANCH=${MASTER_BRANCH:-$DEFAULT_BRANCH}
GIT_URL=https://$GITHUB_ACCESS_TOKEN@github.com/wombatsecurity/$REPO.git
git clone -b $WORKING_BRANCH $GIT_URL app \
  && cd app \
  && GITHUB_SLUG=$REPO \
     GITHUB_ACCESS_TOKEN=$GITHUB_ACCESS_TOKEN \
     PULL_REQUEST_ID=$PULL_REQUEST_ID \
     bundle exec pronto run -f github_pr -c $BRANCH 
