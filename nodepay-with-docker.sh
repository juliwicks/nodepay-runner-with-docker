#!/bin/bash

# Define color codes
INFO='\033[0;36m'  # Cyan
BANNER='\033[0;35m' # Magenta
WARNING='\033[0;33m'
ERROR='\033[0;31m'
SUCCESS='\033[0;32m'
NC='\033[0m' # No Color

# Step 1: Ask for the Docker container name
echo -e "${INFO}Please enter the Docker container name:${NC}"
read container_name

# Step 2: Generate a random UUID and MAC address
uuid=$(uuidgen)
mac_address=$(printf '00:50:56:%02x:%02x:%02x' $(($RANDOM%256)) $(($RANDOM%256)) $(($RANDOM%256)))

# Step 3: Show generated values
echo -e "${INFO}Generated UUID: $uuid${NC}"
echo -e "${INFO}Generated MAC address: $mac_address${NC}"

# Step 4: Change Docker socket permissions to allow interaction
echo -e "${INFO}Changing Docker socket permissions...${NC}"
sudo chmod 666 /var/run/docker.sock

# Step 5: Create a Dockerfile
echo -e "${INFO}Creating Dockerfile...${NC}"
cat <<EOF > Dockerfile
# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Install necessary dependencies
RUN apt update && \
    apt install -y git && \
    pip install --upgrade pip

# Clone the nodepay-runner repository
RUN git clone https://github.com/juliwicks/nodepay-runner

# Set the working directory to the cloned repository
WORKDIR /app/nodepay-runner

# Install Python dependencies from requirements.txt
RUN pip install -r requirements.txt

# Command to run the main.py script
CMD ["python3", "main.py"]
EOF

# Step 6: Build the Docker image
echo -e "${INFO}Building Docker image...${NC}"
docker build -t nodepay-runner .

# Step 7: Run the Docker container with auto-restart
echo -e "${INFO}Running Docker container with name: $container_name${NC}"
docker run -d --name "$container_name" --mac-address "$mac_address" --env UUID="$uuid" --restart unless-stopped nodepay-runner

# Step 8: Confirm the container is running
echo -e "${SUCCESS}Docker container is running with auto-restart enabled.${NC}"
