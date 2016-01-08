#!/bin/bash
printf "Are you sure to remove docker files [y/n]? " && read CONTINUE
if [[ ! $CONTINUE =~ ^[Yy]$ ]]
then
    exit 1
fi

SOURCE_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../../" && pwd )"
ALLFILES=$(ls -A --ignore=www $SOURCE_PATH)

rm -rf $ALLFILES
if [ -d "www" ]; then
    shopt -s dotglob nullglob
    mv -f --backup=numbered www/* .
    rm -r www
fi

echo "================ Docker is removed ! ====================="
