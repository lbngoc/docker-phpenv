#!/bin/bash

source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.common.sh"

output "This command will move all current files, folders to \"src\" and init docker at here."

CONTINUE=$(input "Are you sure to init docker here [y/n]? ")
if [[ ! $CONTINUE =~ ^[Yy]$ ]]
then
	output "[Stopped]" -e && exit 1
fi

CURRENT_PATH=$(pwd)

# Move all current source code to src folder
if [[ ! $CURRENT_PATH = $ROOT_DIR ]]; then
	mkdir -p -- $SOURCE_DIR
	ALLFILES=$(ls -A --ignore=$SOURCE_DIR)
	mv -f --backup=numbered $ALLFILES $SOURCE_DIR/
	cp -rf $ROOT_DIR/* .
fi

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

# Change docker settings
mv docker-project.sublime-project $PROJECT_NAME.sublime-project
# cp docker-compose.yml docker-compose.yml.bak
sed -i "s/9999/$PROJECT_PORT/g" docker-compose.yml
sed -i "s/project_name/$PROJECT_NAME/g" docker-compose.yml
sed -i "s/database_name_here/$PROJECT_DBNAME/g" docker-compose.yml

output "[Success]" -s
output "  - edit \"docker-compose.yml\" if you want to change docker settings." -i
output "  - type \"make\" for get helps to run project with docker." -i
