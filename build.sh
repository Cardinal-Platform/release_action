#!/bin/sh

set -eux

GO111MODULE="on"

PROJECT_NAME=$(basename $GITHUB_REPOSITORY)
PROJECT_ROOT="/home/github.com/${GITHUB_REPOSITORY}"

mkdir -p $PROJECT_ROOT
rmdir $PROJECT_ROOT
ln -s $GITHUB_WORKSPACE $PROJECT_ROOT
cd $PROJECT_ROOT

cd src

EXT=''

if [ $GOOS == 'windows' ]; then
  EXT='.exe'
fi

go build -ldflags "-w -s" -v -o "${PROJECT_NAME}${EXT}"