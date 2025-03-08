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

# Download Docker images
curl -o workerservice1_latest.tar.gz ftp://$FTP_SERVER/docker_images/workerservice1_latest.tar.gz --user $USERNAME:$PASSWORD
curl -o workerservice2_latest.tar.gz ftp://$FTP_SERVER/docker_images/workerservice2_latest.tar.gz --user $USERNAME:$PASSWORD

# Load Docker images
docker load -i workerservice1_latest.tar.gz
docker load -i workerservice2_latest.tar.gz

# Run Docker containers
docker-compose up

# Remove local files after upload
rm workerservice1_latest.tar.gz
rm workerservice2_latest.tar.gz