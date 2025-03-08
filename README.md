# Demo docker worker services

This project contains two .NET worker services and Docker configurations for their deployment.

## How to Run

To build the Docker images and upload them to an FTP server, follow these steps:

1. Ensure you have Docker and Docker Compose installed.
2. Open a terminal (e.g., Git Bash, WSL, or PowerShell with Bash support).
3. Navigate to the directory containing the `build.sh` script.
4. Run the script with the following command, replacing `<ftp_server>`, `<username>`, and `<password>` with your FTP server details:

Example: `bash build.sh ftp.example.com myusername mypassword`

This will build the Docker images, save them as compressed files, and upload them to the specified FTP server.

## How to Install

To download and load the Docker images from the FTP server, follow these steps:

1. Ensure you have Docker installed.
2. Open a terminal (e.g., Git Bash, WSL, or PowerShell with Bash support).
3. Navigate to the directory containing the `install.sh` script.
4. Run the script with the following command, replacing `<ftp_server>`, `<username>`, and `<password>` with your FTP server details:

Example: `bash install.sh ftp.example.com myusername mypassword`

This will download the Docker images from the specified FTP server and load them into Docker.

## How to Update

To check for updates and download the latest Docker images from the FTP server, follow these steps:

1. Ensure you have Docker installed.
2. Open a terminal (e.g., Git Bash, WSL, or PowerShell with Bash support).
3. Navigate to the directory containing the `update.sh` script.
4. Run the script with the following command, replacing `<ftp_server>`, `<username>`, and `<password>` with your FTP server details:

Example: `bash update.sh ftp.example.com myusername mypassword`

This will check for updates by comparing the local versions file with the latest versions file on the FTP server. If new versions are available, it will download and load the latest Docker images.

## How it Works

### Build Process

1. The `build.sh` script builds the Docker images for the worker services using Docker Compose.
2. The images are saved as compressed files (`.tar.gz`).
3. The script retrieves the image digests (unique identifiers) and saves them to a `versions.txt` file.
4. The images and the `versions.txt` file are uploaded to the specified FTP server.
5. Local copies of the images and the `versions.txt` file are removed.

### Install Process

1. The `install.sh` script downloads the `versions.txt` file from the FTP server.
2. It then downloads the Docker images specified in the `versions.txt` file.
3. The images are loaded into Docker.
4. The script runs the Docker containers using Docker Compose.
5. Local copies of the downloaded images are removed.

### Update Process

1. The `update.sh` script downloads the latest `versions.txt` file from the FTP server.
2. It compares the local `versions.txt` file with the downloaded one.
3. If there are new versions available, it downloads the new Docker images.
4. The images are loaded into Docker.
5. Local copies of the downloaded images are removed.
6. The local `versions.txt` file is updated with the latest versions.

This setup ensures that you can easily build, install, and update your Docker images and keep your services up-to-date with minimal effort.
