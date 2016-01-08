#!/bin/bash

echo "Server is running..."

HTTP=$(docker-compose port web 80)
MYSQL=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $(docker-compose ps | awk '/mysql/ {print $1}'))

echo "  - website : http://$HTTP"
echo "  - mysql   : tcp://$MYSQL:3306"
