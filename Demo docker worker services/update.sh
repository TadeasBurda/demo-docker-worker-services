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

# Download the latest versions file from FTP server
curl -o versions_latest.txt ftp://$FTP_SERVER/docker_images/versions.txt --user $USERNAME:$PASSWORD

# Check if the versions file exists locally
if [ -f versions.txt ]; then
    # Compare the local versions with the latest versions
    if ! cmp -s versions.txt versions_latest.txt; then
        echo "New versions available. Updating..."

        # Download the latest Docker images
        curl -o workerservice1_latest.tar.gz ftp://$FTP_SERVER/docker_images/workerservice1_latest.tar.gz --user $USERNAME:$PASSWORD
        curl -o workerservice2_latest.tar.gz ftp://$FTP_SERVER/docker_images/workerservice2_latest.tar.gz --user $USERNAME:$PASSWORD

        # Load the Docker images
        docker load -i workerservice1_latest.tar.gz
        docker load -i workerservice2_latest.tar.gz

        # Remove the downloaded files
        rm workerservice1_latest.tar.gz
        rm workerservice2_latest.tar.gz

        # Update the local versions file
        mv versions_latest.txt versions.txt

        echo "Update completed."
    else
        echo "No updates available."
        rm versions_latest.txt
    fi
else
    echo "Local versions file not found. Downloading the latest versions..."

    # Download the latest Docker images
    curl -o workerservice1_latest.tar.gz ftp://$FTP_SERVER/docker_images/workerservice1_latest.tar.gz --user $USERNAME:$PASSWORD
    curl -o workerservice2_latest.tar.gz ftp://$FTP_SERVER/docker_images/workerservice2_latest.tar.gz --user $USERNAME:$PASSWORD

    # Load the Docker images
    docker load -i workerservice1_latest.tar.gz
    docker load -i workerservice2_latest.tar.gz

    # Remove the downloaded files
    rm workerservice1_latest.tar.gz
    rm workerservice2_latest.tar.gz

    # Save the latest versions file locally
    mv versions_latest.txt versions.txt

    echo "Initial download and update completed."
fi
