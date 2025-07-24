#!/bin/bash

# Installer Script for Draco and Skyport Panels
# Author: [Your Name or GitHub Handle]

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m' # Yellow for prompts
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

# Display main menu
echo_message "====================="
echo_message "Select an option:"
echo "1) Install Panel"
echo "2) Run Daemon"
echo "3) Start Panel"
echo "4) Start Daemon"
echo "5) Exit"
echo_message "====================="

# Read user input for main menu
read -p "Enter your choice [1-5]: " choice

case $choice in
  1)
    # Sub-menu for panel installation
    echo_message "====================="
    echo_message "Select a panel to install:"
    echo "1) Draco Panel"
    echo "2) Skyport Panel"
    echo_message "====================="
    read -p "Enter your choice [1-2]: " panel_choice
    case $panel_choice in
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
      *)
        echo -e "${RED}Invalid selection. Returning to main menu.${NC}"
        exit 1
        ;;
    esac
    ;;
  2)
    echo_message "Running Daemon..."
    bash <(curl -s https://raw.githubusercontent.com/JishnuTheGamer/Vps/refs/heads/main/daemon)
    echo_message "Daemon has been executed!"
    ;;
  3)
    echo_message "Starting Panel..."
    cd v3panel && pm2 start panel
    echo_message "Panel has been started!"
    ;;
  4)
    echo_message "Starting Daemon..."
    cd daemon && pm2 start daemon
    echo_message "Daemon has been started!"
    ;;
  5)
    echo_message "Exiting..."
    exit 0
    ;;
  *)
    echo -e "${RED}Invalid selection. Please run the script again and choose a valid option.${NC}"
    exit 1
    ;;
esac

# Prompt to install the daemon (wings) after panel installation
if [[ "$choice" == "1" ]]; then
  echo -e "${YELLOW}Do you want to install the daemon (wings)? (yes/no): ${NC}"
  read install_daemon
  if [[ "$install_daemon" == "yes" || "$install_daemon" == "y" ]]; then
    echo_message "Installing Daemon (wings)..."
    bash <(curl -s https://raw.githubusercontent.com/JishnuTheGamer/Vps/refs/heads/main/daemon)
    echo_message "Daemon (wings) installation completed!"
  else
    echo_message "Daemon (wings) installation skipped."
  fi
fi
