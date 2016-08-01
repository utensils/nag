#!/bin/ash
# This script is a simple wrapper around Pronto for our Docker container 

DEFAULT_BRANCH='origin/master'

export PATH=$(ruby -rubygems -e 'puts Gem.user_dir')/bin:$PATH

BRANCH=${MASTER_BRANCH:-$DEFAULT_BRANCH}
GIT_URL=https://$GITHUB_ACCESS_TOKEN@github.com/$REPO \

git clone $GIT_URL repo \
  && cd repo \
  && git fetch --all \
  && git checkout $WORKING_BRANCH \
  && git pull origin HEAD \
  && GITHUB_SLUG=$REPO \
     GITHUB_ACCESS_TOKEN=$GITHUB_ACCESS_TOKEN \
     PULL_REQUEST_ID=$PULL_REQUEST_ID \
     bundle exec pronto run -f github_pr -c $BRANCH 
