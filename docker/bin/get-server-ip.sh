#!/bin/bash

source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.common.sh"

output "Server is running..." -s

HTTP=$(docker-compose port web 80)
MYSQL=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $(docker-compose ps | awk '/mysql/ {print $1}'))

output "  - website : http://$HTTP"
output "  - mysql   : tcp://$MYSQL:3306"
