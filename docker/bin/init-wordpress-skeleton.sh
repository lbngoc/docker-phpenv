#!/bin/bash

source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.common.sh"

# Check git
git --version 2>&1 >/dev/null # improvement by tripleee
GIT_IS_AVAILABLE=$?

if [ ! $GIT_IS_AVAILABLE -eq 0 ]; then
	output "Git is not found. Please install git first." -e
	exit 1
fi

# Confirm
output "This command will download and init a Wordpress Skeleton into your \"src\" folder." -w
# printf "Are you sure to continue [y/n]? " && read CONTINUE
CONTINUE=$(input "Are you sure to continue [y/n]? ")
if [[ ! $CONTINUE =~ ^[Yy]$ ]]
then
	output "[Stopped]" -e && exit 1
fi

mkdir -p -- $SOURCE_DIR
# Check src folder
if [[ "$(ls -A $SOURCE_DIR)" ]]; then
	output "Folder \"src\" is not an empty directory." -e && exit 1
else
	DOWNLOAD_WP=$(input "Download WordPress Core [y/n]? ")
	# Clone source code
	if [[ ! $DOWNLOAD_WP =~ ^[Yy]$ ]]; then
		LOCAL_WP=$(input "Enter your local WordPress Core path: ")
		git clone https://github.com/lbngoc/WordPress-Skeleton.git $SOURCE_DIR
		LOCAL_WP=${LOCAL_WP/\~\//$HOME/}
		if [[ -d "$LOCAL_WP" ]]; then
			rm -rf $SOURCE_DIR/wp && ln -s $LOCAL_WP $SOURCE_DIR/wp
			sed -i "s@#- LOCAL_WP_PATH@- $LOCAL_WP@g" docker-compose.yml
		fi
	else
		git clone --recursive https://github.com/lbngoc/WordPress-Skeleton.git $SOURCE_DIR
	fi
	# Remove git
	rm -rf $SOURCE_DIR/.git

	output "Run this command to complete setup \"sudo chown -R www-data src/wp-content\"";
	output "[Success]" -s
fi
