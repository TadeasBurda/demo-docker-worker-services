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
        while IFS= read -r line; do
            service=$(echo $line | cut -d':' -f1)
            version=$(echo $line | cut -d':' -f2)
            curl -o ${service}_${version}.tar.gz ftp://$FTP_SERVER/docker_images/${service}_${version}.tar.gz --user $USERNAME:$PASSWORD
            docker load -i ${service}_${version}.tar.gz
            rm ${service}_${version}.tar.gz
        done < versions_latest.txt

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
    while IFS= read -r line; do
        service=$(echo $line | cut -d':' -f1)
        version=$(echo $line | cut -d':' -f2)
        curl -o ${service}_${version}.tar.gz ftp://$FTP_SERVER/docker_images/${service}_${version}.tar.gz --user $USERNAME:$PASSWORD
        docker load -i ${service}_${version}.tar.gz
        rm ${service}_${version}.tar.gz
    done < versions_latest.txt

    # Save the latest versions file locally
    mv versions_latest.txt versions.txt

    echo "Initial download and update completed."
fi

# Run Docker containers
docker-compose up