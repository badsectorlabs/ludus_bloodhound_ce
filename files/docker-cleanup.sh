#!/bin/bash

# Remove all Docker containers
docker rm -f $(docker ps -a -q)

# Remove all Docker volumes
docker volume rm $(docker volume ls -q)