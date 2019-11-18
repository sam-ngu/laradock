#!/bin/bash
# helper script to start all the relevant docker container

# defining all the services here
services=('nginx' 'mysql' )

# argument 1 accept a user, which will be the ssh user
# eg. ./up.sh root  will ssh as root
if [ $# -gt 0 ]
then
  user=$1
else
  user=laradock
fi

docker-compose up -d "${services[@]}" && docker-compose exec --user="$user" workspace bash
