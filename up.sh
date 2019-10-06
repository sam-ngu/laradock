#!/bin/bash
# helper script to start all the relevant docker container

# defining all the services here
services=('nginx' 'mysql' )

docker-compose up -d "${services[@]}" && docker-compose exec workspace bash
