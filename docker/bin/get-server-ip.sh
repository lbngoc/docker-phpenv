#!/bin/bash

source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.common.sh"

output s "Server is running..."

HTTP=$(docker-compose port web 80)
MYSQL=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $(docker-compose ps | awk '/mysql/ {print $1}'))

output i "  - website : http://$HTTP"
output i "  - mysql   : tcp://$MYSQL:3306"
