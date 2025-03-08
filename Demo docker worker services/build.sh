#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <ftp_server> <username> <password>"
    exit 1
fi

# Assign arguments to variables
FTP_SERVER=$1
USERNAME=$2
PASSWORD=$3

# Build Docker images
docker-compose build
docker save workerservice1 | gzip > workerservice1.tar.gz
docker save workerservice2 | gzip > workerservice2.tar.gz

# Upload to FTP server
curl -T workerservice1.tar.gz ftp://$FTP_SERVER/docker_images/ --user $USERNAME:$PASSWORD
curl -T workerservice2.tar.gz ftp://$FTP_SERVER/docker_images/ --user $USERNAME:$PASSWORD
