#!/usr/bin/env bash

# create container if it does not exist
docker volume create dashboard_volume

# run container
docker run --name 'dashboard' -p 80:80 -v dashboard_volume:/var/www/html afdaniele/rpi-duckiebot-dashboard:latest
