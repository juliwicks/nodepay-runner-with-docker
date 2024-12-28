# NodePay Runner with Docker Setup

This repository contains a script to easily set up and run the NodePay Runner using Docker.

## Prerequisites

- Docker must be installed on your system. If you don't have Docker installed, please follow the [official Docker installation guide](https://docs.docker.com/get-docker/) for your platform.

## Basic Script

You can go here if you don't want to use Docker: https://github.com/juliwicks/nodepay-runner

## Instructions

Follow the steps below to run the `nodepay-with-docker.sh` script to set up the NodePay Runner inside a Docker container.

### Step 1: Download and Run the Setup Script

You can run the setup script directly using `curl` by executing the following one-liner command in your terminal:

```bash
curl -sSL https://raw.githubusercontent.com/juliwicks/nodepay-runner-with-docker/refs/heads/main/nodepay-with-docker.sh && chmod +x nodepay-with-docker.sh && ./nodepay-with-docker.sh
