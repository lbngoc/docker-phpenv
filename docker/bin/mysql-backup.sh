#!/bin/bash

source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.common.sh"

BACKUP_DIR="docker/$BACKUP_DIR_NAME"
FILENAME=$MYSQL_DATABASE.$(date +%Y-%m-%d-%H.%M.%S)

output "Exporting your database..."

mkdir -p -- /$BACKUP_DIR
mysqldump -hmysql -u$MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE | gzip -c > "/$BACKUP_DIR/$FILENAME.sql.gz"

output "[Success] Backup is saved at $BACKUP_DIR/$FILENAME.sql.gz" -s
