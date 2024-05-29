#!/bin/bash

cd /home
mkdir xui && cd xui
wget https://raw.githubusercontent.com/Chasing66/beautiful_docker/main/x-ui/docker-compose.yml
docker-compose up -d
