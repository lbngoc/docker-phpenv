# ARGS = $(filter-out $@,$(MAKECMDGOALS))

all:
	@echo "Usage: make <command>"
	@echo "Commands:"
	@echo "  serve                    : Start server in foreground."
	@echo "  start                    : Start server in background."
	@echo "  stop                     : Stop all running server."
	@echo "  rebuild                  : Stop all running container and rebuild docker image file."
	@echo "  ssh                      : Connect to virtual docker container."
	@echo "  mysql-backup             : Backup current database to file."
	@echo "  mysql-restore <filename> : Restore exported database file."
	@echo "  init-wordpress           : Init wordpress skeleton into your \"src\" folder."
	@echo "\nFor more details, visit [http://ngoclb.com/docker-phpenv]"

ssh:
	docker-compose run --rm web bash

serve:
	docker-compose up

start:
	docker-compose up -d
	bash docker/bin/get-server-ip.sh

stop:
	docker-compose stop

rebuild:
	docker-compose stop mysql web
	docker-compose build

mysql-backup:
	docker-compose run --rm mysql bash /docker/bin/mysql-backup.sh

mysql-restore:
	docker-compose run --rm mysql bash /docker/bin/mysql-restore.sh

init-wordpress:
	bash docker/bin/init-wordpress-skeleton.sh
