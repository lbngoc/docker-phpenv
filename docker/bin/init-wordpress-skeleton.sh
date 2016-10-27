#!/bin/bash

source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.common.sh"

# Check git
git --version 2>&1 >/dev/null # improvement by tripleee
GIT_IS_AVAILABLE=$?

if [ ! $GIT_IS_AVAILABLE -eq 0 ]; then
	output e "Git is not found. Please install git first."
	exit 1
fi

# Confirm
output "This command download and init a Wordpress Skeleton into your \"src\" folder."
# printf "Are you sure to continue [y/n]? " && read CONTINUE
CONTINUE=$(input "Are you sure to continue [y/n]? ")
if [[ ! $CONTINUE =~ ^[Yy]$ ]]
then
	output "[Stopped]" -e && exit 1
fi

mkdir -p -- $SOURCE_DIR
# Check src folder
if [ ! "$(ls -a $SOURCE_DIR)" ]; then
	output "Folder \"src\" is not empty." -e && exit 1
else
	DOWNLOAD_WP=$(input "Download WordPress Core [y/n]?")
	if [[ ! $DOWNLOAD_WP =~ ^[Yy]$ ]]] then
		git clone https://github.com/lbngoc/WordPress-Skeleton.git $SOURCE_DIR
	else
		git clone --recursive https://github.com/lbngoc/WordPress-Skeleton.git $SOURCE_DIR
	fi
	output "[Success]" -s
fi
