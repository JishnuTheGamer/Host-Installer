#!/bin/bash

# Installer Script for Draco and Skyport Panels
# Author: [Your Name or GitHub Handle]

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to display messages
function echo_message {
  echo -e "${CYAN}$1${NC}"
}

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Please run this script as root.${NC}"
  exit 1
fi

# Display menu
echo_message "Select a panel to install:"
echo "1) Draco Panel"
echo "2) Skyport Panel"
echo "3) Exit"

# Read user input
read -p "Enter your choice [1-3]: " choice

case $choice in
  1)
    echo_message "Installing Draco Panel..."
    bash <(curl -s https://raw.githubusercontent.com/JishnuTheGamer/Vps/refs/heads/main/jishnu)
    echo_message "Draco Panel installation completed!"
    ;;
  2)
    echo_message "Installing Skyport Panel..."
    bash <(curl -s https://raw.githubusercontent.com/JishnuTheGamer/skyport/refs/heads/main/panel)
    echo_message "Skyport Panel installation completed!"
    ;;
  3)
    echo_message "Exiting..."
    exit 0
    ;;
  *)
    echo -e "${RED}Invalid selection. Please run the script again and choose a valid option.${NC}"
    exit 1
    ;;
esac
