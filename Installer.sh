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
echo_message "====================="
echo_message "Select an option:"
echo "1) Install Draco Panel"
echo "2) Install Skyport Panel"
echo "3) Run Daemon"
echo "4) Exit"
echo_message "====================="

# Read user input
read -p "Enter your choice [1-4]: " choice

case $choice in
  1)
    echo_message "Installing Draco Panel..."
    bash <(curl -s https://raw.githubusercontent.com/JishnuTheGamer/Vps/refs/heads/main/draco)
    echo_message "Draco Panel installation completed!"
    ;;
  2)
    echo_message "Installing Skyport Panel..."
    bash <(curl -s https://raw.githubusercontent.com/JishnuTheGamer/Vps/refs/heads/main/skyport)
    echo_message "Skyport Panel installation completed!"
    ;;
  3)
    echo_message "Running Daemon..."
    bash <(curl -s https://raw.githubusercontent.com/JishnuTheGamer/Vps/refs/heads/main/daemon)
    echo_message "Daemon has been executed!"
    ;;
  4)
    echo_message "Exiting..."
    exit 0
    ;;
  *)
    echo -e "${RED}Invalid selection. Please run the script again and choose a valid option.${NC}"
    exit 1
    ;;
esac

# Prompt to install the daemon (wings) after panel installation
if [[ "$choice" == "1" || "$choice" == "2" ]]; then
  read -p "Do you want to install the daemon (wings)? (yes/no): " install_daemon
  if [[ "$install_daemon" == "yes" || "$install_daemon" == "y" ]]; then
    echo_message "Installing Daemon (wings)..."
    bash <(curl -s https://raw.githubusercontent.com/JishnuTheGamer/Vps/refs/heads/main/daemon)
    echo_message "Daemon (wings) installation completed!"
  else
    echo_message "Daemon (wings) installation skipped."
  fi
fi
