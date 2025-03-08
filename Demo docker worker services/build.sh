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

# Save Docker images with tag 'latest'
docker save workerservice1:latest | gzip > workerservice1_latest.tar.gz
docker save workerservice2:latest | gzip > workerservice2_latest.tar.gz

# Upload to FTP server
curl -T workerservice1_latest.tar.gz ftp://$FTP_SERVER/docker_images/ --user $USERNAME:$PASSWORD
curl -T workerservice2_latest.tar.gz ftp://$FTP_SERVER/docker_images/ --user $USERNAME:$PASSWORD

# Remove local files after upload
rm workerservice1_latest.tar.gz
rm workerservice2_latest.tar.gz
