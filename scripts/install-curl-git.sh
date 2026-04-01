#!/bin/bash
set -e

echo "Installing curl and git..."
sudo apt update
sudo apt install -y curl git
echo "curl and git installed successfully."
