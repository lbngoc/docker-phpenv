#!/bin/bash
printf "Are you sure to init docker here [y/n]? " && read CONTINUE
if [[ ! $CONTINUE =~ ^[Yy]$ ]]
then
    exit 1
fi

CURRENT_PATH=$(pwd)
SOURCE_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../../" && pwd )"

# Move all current source code to www folder
if [[ ! $CURRENT_PATH = $SOURCE_PATH ]]; then
    mkdir -p -- www
    ALLFILES=$(ls -A --ignore=www)
    mv -f --backup=numbered $ALLFILES www/
    cp -rf $SOURCE_PATH/* .
fi

# Get input settings from user
while [[ ! $PROJECT_NAME =~ ^[A-Za-z0-9-]+$ ]]; do
    printf ">> Enter project name [a-zA-Z0-9-]: " && read PROJECT_NAME
done

while [[ ! $PROJECT_PORT =~ ^[1-9][0-9]{3,4}$ ]]; do
    printf ">> Enter docker application port [1000~99999]: " && read PROJECT_PORT
done

while [[ ! $PROJECT_DBNAME =~ ^[A-Za-z0-9-]+$ ]]; do
    printf ">> Enter database name [a-zA-Z0-9-]: " && read PROJECT_DBNAME
done

# Change docker settings
mv docker-project.sublime-project $PROJECT_NAME.sublime-project
cp docker-compose.yml docker-compose.yml.bak
sed -i "s/9999/$PROJECT_PORT/g" docker-compose.yml
sed -i "s/database_name_here/$PROJECT_DBNAME/g" docker-compose.yml

echo "================ Docker is initialized ! ====================="
echo "  - edit \"docker-compose.yml\" if you want to change docker settings."
echo "  - type \"make\" for get helps to run project with docker."



