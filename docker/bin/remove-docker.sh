#!/bin/bash

source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.common.sh"

output "WARNING: This command will remove all files and folders at here and move all files in \"src\" to here !!!\nIt will be better if you can do it manually." -w
CONTINUE=$(input "Are you sure to remove docker files [y/n]? ")
if [[ ! $CONTINUE =~ ^[Yy]$ ]]
then
	output "[Stopped]" -e && exit 1
fi

SOURCE_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../../" && pwd )"
ALLFILES=$(ls -A --ignore=src $SOURCE_PATH)

rm -rf $ALLFILES
if [ -d "src" ]; then
	shopt -s dotglob nullglob
	mv -f --backup=numbered src/* .
	rm -r src
fi

output "[Success] Docker is removed." -s
