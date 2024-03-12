#!/usr/bin/sh
# docker build -t docker-example . && docker run -p 5000:5000 -p 3005:3005 docker-example:latest

docker-compose build && docker-compose up -d