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
