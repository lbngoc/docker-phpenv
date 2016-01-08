#!/bin/bash

BACKUP_DIR=docker/backup
FILENAME=$MYSQL_DATABASE.$(date +%Y-%m-%d-%H.%M.%S)

echo "=== Exported SQL Files ==="
ls /$BACKUP_DIR | grep ".sql.gz"
echo "=========================="
printf ">> Enter file name: " && read FILENAME

if [ ! -f "/$BACKUP_DIR/$FILENAME" ]; then
    echo ">> File does not exits."
    exit 0
fi

gunzip < /$BACKUP_DIR/$FILENAME | mysql -hmysql -u$MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE

echo ">> File $BACKUP_DIR/$FILENAME.sql.gz is imported."
