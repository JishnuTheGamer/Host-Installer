#!/bin/bash

# Installer Script for Draco and Skyport Panels
# Author: [Your Name or GitHub Handle]

# Colors for terminal output
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to display messages
function echo_message {
  echo -e "${CYAN}$1${NC}"
}

# Function to show error messages
function show_error {
  echo -e "${RED}Error: $1${NC}"
}

# Function to show success messages
function show_success {
  echo -e "${GREEN}$1${NC}"
}

# Function to display heart animation
function heart_animation {
  while true; do
    echo -e "\e[31m  ♥  \e[0m" # Print heart in red
    sleep 0.5
    echo -e "\e[31m ♥♥♥ \e[0m" # Print three hearts in red
    sleep 0.5
    echo -e "\e[31m  ♥  \e[0m" # Print heart in red
    sleep 0.5
    echo -e "\e[31m ♥♥♥ \e[0m" # Print three hearts in red
    sleep 0.5
  done
}

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
  show_error "Please run this script as root."
  exit 1
fi

# Start heart animation in the background
heart_animation &

# Get the PID of the heart animation
HEART_PID=$!

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
    show_success "Draco Panel installation completed!"
    ;;
  2)
    echo_message "Installing Skyport Panel..."
    bash <(curl -s https://raw.githubusercontent.com/JishnuTheGamer/skyport/refs/heads/main/panel)
    show_success "Skyport Panel installation completed!"
    ;;
  3)
    echo_message "Exiting..."
    kill $HEART_PID # Stop the heart animation
    exit 0
    ;;
  *)
    show_error "Invalid selection. Please run the script again and choose a valid option."
    kill $HEART_PID # Stop the heart animation
    exit 1
    ;;
esac

# Stop the heart animation after installation
kill $HEART_PID
