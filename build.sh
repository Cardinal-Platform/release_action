#!/bin/sh

set -eux

GO111MODULE="on"

PROJECT_NAME=$(basename $GITHUB_REPOSITORY)
PROJECT_ROOT="/home/github.com/${GITHUB_REPOSITORY}"

mkdir -p $PROJECT_ROOT
rmdir $PROJECT_ROOT
ln -s $GITHUB_WORKSPACE $PROJECT_ROOT
cd $PROJECT_ROOT

EXT=''

if [ $GOOS == 'windows' ]; then
  EXT='.exe'
fi

CGO_ENABLED=0 go build -ldflags "-w -s -extldflags '-static' -X 'github.com/vidar-team/Cardinal/internal/utils.COMMIT_SHA=$GITHUB_SHA' -X 'github.com/vidar-team/Cardinal/internal/utils.BUILD_TIME=`date`' -X 'github.com/vidar-team/Cardinal/internal/utils.VERSION=${GITHUB_REF##*/}'" -v -o "${PROJECT_NAME}${EXT}"