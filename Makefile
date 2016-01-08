ARGS = $(filter-out $@,$(MAKECMDGOALS))

all:
	@echo "Usage: "
	@echo "  make dev                             : Start server in foreground."
	@echo "  make start                           : Start server in background."
	@echo "  make cleanup                         : Stop all running container and rebuild image."
	@echo "  make ssh                             : Connect to virtual docker container."
	@echo "  make mysql-backup                    : Backup current database to compressed file."
	@echo "  make mysql-restore [filename.sql.bz] : Restore compressed file to current database."

ssh:
	docker-compose run --rm web bash

dev:
	docker-compose up

start:
	docker-compose up -d
	bash docker/bin/get-server-ip.sh

stop:
	docker-compose stop

cleanup:
	docker-compose stop mysql web
	docker-compose build

mysql-backup:
	docker-compose run --rm mysql bash /docker/bin/mysql-backup.sh

mysql-restore:
	docker-compose run --rm mysql bash /docker/bin/mysql-restore.sh

