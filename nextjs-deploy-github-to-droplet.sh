#!/bin/bash

# Variables
ROOT_FOLDER='/root/next'
PM2_SERVICE_NAME="cyberdining-next"
SRC_FOLDER="$ROOT_FOLDER/cyberdining-next13-pages-ts-v1"
REPO_URL="https://github.com/ahmedmusawir/cyberdining-next13-pages-ts-v1.git"
TIMESTAMP="$ROOT_FOLDER/$(date +"BK%Y-%m-%d-%H%M%S")"

# Create a backup folder
echo "--------------------------"
echo "Creating Backup folder ..."
echo "--------------------------"
mkdir -p "$TIMESTAMP"

# Stop and remove PM2 service
echo "----------------------------------------"
echo "Stopping PM2 service: $PM2_SERVICE_NAME"
echo "----------------------------------------"
pm2 delete "$PM2_SERVICE_NAME"

# Remove node_modules and move the source folder to the backup
echo "---------------------------------------------"
echo "Removing node_modules from $SRC_FOLDER ..."
echo "---------------------------------------------"
rm -rf "$SRC_FOLDER/node_modules"

echo "---------------------------------------------"
echo "Moving $SRC_FOLDER to $TIMESTAMP ..."
echo "---------------------------------------------"
mv "$SRC_FOLDER" "$TIMESTAMP"

# Clone the repository
echo "---------------------------------------------"
echo "Cloning repository: $REPO_URL ..."
echo "---------------------------------------------"
git clone "$REPO_URL" "$SRC_FOLDER"

# Install dependencies and build
cd "$SRC_FOLDER"
echo "---------------------------------------------"
echo "Installing dependencies ..."
echo "---------------------------------------------"
npm install

echo "---------------------------------------------"
echo "Building the project ..."
echo "---------------------------------------------"
npm run build

# Start the service with PM2
echo "---------------------------------------------"
echo "Starting the service with PM2 ..."
echo "---------------------------------------------"
pm2 start npm --name "$PM2_SERVICE_NAME" -- run start

# Show PM2 status
echo "---------------------------------------------"
echo "PM2 Status:"
echo "---------------------------------------------"
pm2 status

echo "---------------------------------------------"
echo "Script execution completed!"
echo "---------------------------------------------"


