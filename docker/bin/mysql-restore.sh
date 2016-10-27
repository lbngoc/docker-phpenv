#!/bin/bash

source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.common.sh"

BACKUP_DIR=docker/backup
FILENAME=$MYSQL_DATABASE.$(date +%Y-%m-%d-%H.%M.%S)

output "Available backup:" -i
output "---" -i
ls /$BACKUP_DIR | grep -E "\.sql(\.gz)?$"
# output "==========================" -i
FILENAME=$(input "Enter file name: ")

if [ ! -f "/$BACKUP_DIR/$FILENAME" ]; then
	output "File does not exits." -e &&	exit 0
fi

if [ $FILENAME =~  ^.*\.sql\.gz$ ] then
	gunzip < "/$BACKUP_DIR/$FILENAME" | mysql -hmysql -u$MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE
else
	mysql -hmysql -u$MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE < "/$BACKUP_DIR/$FILENAME"
fi

output "[Success] File "$BACKUP_DIR/$FILENAME" is imported." -s
