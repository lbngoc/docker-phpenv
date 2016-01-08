#!/bin/bash

BACKUP_DIR=docker/backup
FILENAME=$MYSQL_DATABASE.$(date +%Y-%m-%d-%H.%M.%S)

mkdir -p -- /$BACKUP_DIR
mysqldump -hmysql -u$MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE | gzip -c > "/$BACKUP_DIR/$FILENAME.sql.gz"
echo ">> Backup file is saved at $BACKUP_DIR/$FILENAME.sql.gz"