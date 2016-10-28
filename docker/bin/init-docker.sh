#!/bin/bash

source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.common.sh"

if [[ $CURRENT_DIR = $ROOT_DIR ]]; then
	output "[Stopped] You can not run this command at here." -e && exit 1
fi

output "This command will move all current files, folders to \"src\" folder and init docker at here." -w

CONTINUE=$(input "Are you sure to init docker here [y/n]? ")
if [[ ! $CONTINUE =~ ^[Yy]$ ]]
then
	output "[Stopped]" -e && exit 1
fi

if [[ -d "$SOURCE_DIR_NAME" ]]; then
	CONTINUE=$(input "The \"$SOURCE_DIR_NAME\" is already exits. Are you want to backup this and continue [y/n]? ")
	if [[ $CONTINUE =~ ^[Yy]$ ]]; then
		mv -f --backup=numbered $SOURCE_DIR_NAME "$SOURCE_DIR_NAME-original"
	else
		output "[Stopped]" -e && exit 1
	fi
fi

# echo $CURRENT_PATH
# echo $SCRIPT_DIR
# echo $ROOT_DIR
# echo $SOURCE_DIR
# exit 1

# Move all current source code to src folder
# shopt -s dotglob #considering dot files
mkdir -p -- $SOURCE_DIR_NAME
# move all to src folder
# ALLFILES=$(ls -A --ignore=.git --ignore=$SOURCE_DIR_NAME)
# mv -f --backup=numbered $ALLFILES $SOURCE_DIR_NAME
rsync -r --exclude=$SOURCE_DIR_NAME --remove-source-files $CURRENT_DIR/ $SOURCE_DIR_NAME
# copy docker file to current folder
rsync -r --exclude=.git --exclude=docker-project.sublime-workspace $ROOT_DIR/ $CURRENT_DIR

# Get input settings from user
while [[ ! $PROJECT_NAME =~ ^[A-Za-z0-9-]+$ ]]; do
	PROJECT_NAME=$(input "Enter project name [a-zA-Z0-9-]: ")
done

while [[ ! $PROJECT_PORT =~ ^[1-9][0-9]{3,4}$ ]]; do
	PROJECT_PORT=$(input "Enter docker application port [1000~99999]: ")
done

while [[ ! $PROJECT_DBNAME =~ ^[A-Za-z0-9-]+$ ]]; do
	PROJECT_DBNAME=$(input "Enter database name [a-zA-Z0-9-]: ")
done

# Clear or rename some files
mv docker-project.sublime-project $PROJECT_NAME.sublime-project
rm docker/bin/init-docker.sh
# cp docker-compose.yml docker-compose.yml.bak
# Change docker settings
sed -i "s/9999/$PROJECT_PORT/g" docker-compose.yml
sed -i "s/project_name/$PROJECT_NAME/g" docker-compose.yml
sed -i "s/database_name_here/$PROJECT_DBNAME/g" docker-compose.yml

output "[Success]" -s
output "  - edit \"docker-compose.yml\" if you want to change docker settings."
output "  - type \"make\" for get helps to run project with docker."
