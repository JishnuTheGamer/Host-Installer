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

# Function for Main Menu
function main_menu {
  while true; do
    echo_message "===================== Main Menu: 1) Install Panel 2) Exit ====================="
    read -p "Enter your choice [1-2]: " choice
    case $choice in
      1) panel_menu ;;
      2) echo_message "Exiting..."; exit 0 ;;
      *) echo -e "${RED}Invalid selection. Try again.${NC}" ;;
    esac
  done
}

# Function for Panel Selection Sub-Menu
function panel_menu {
  while true; do
    echo_message "===================== Select Panel Type: 1) Draco 2) Skyport 3) Back ====================="
    read -p "Enter your choice [1-3]: " sub_choice
    case $sub_choice in
      1) draco_menu ;;
      2) skyport_menu ;;
      3) return ;;  # Back to main menu
      *) echo -e "${RED}Invalid selection. Try again.${NC}" ;;
    esac
  done
}

# Function for Draco Sub-Sub-Menu
function draco_menu {
  while true; do
    echo_message "===================== Draco Options: 1) Install Draco Panel 2) Install Draco Daemon (wings) 3) Start Panel 4) Start Daemon 5) Back ====================="
    read -p "Enter your choice [1-5]: " draco_choice
    case $draco_choice in
      1)
        echo_message "Installing Draco Panel..."
        bash <(curl -s https://raw.githubusercontent.com/JishnuTheGamer/Vps/refs/heads/main/draco)
        echo_message "Draco Panel installation completed!"
        prompt_daemon
        ;;
      2)
        echo_message "Installing Draco Daemon (wings)..."
        bash <(curl -s https://raw.githubusercontent.com/JishnuTheGamer/Vps/refs/heads/main/daemon)
        echo_message "Draco Daemon (wings) installation completed!"
        ;;
      3)
        echo_message "Starting Panel..."
        cd panel && cd panel && node .
        echo_message "Panel has been started!"
        ;;
      4)
        echo_message "Starting Daemon..."
        cd daemon && cd daemon && node .
        echo_message "Daemon has been started!"
        ;;
      5) return ;;  # Back to panel menu
      *) echo -e "${RED}Invalid selection. Try again.${NC}" ;;
    esac
  done
}

# Function for Skyport Sub-Sub-Menu
function skyport_menu {
  while true; do
    echo_message "===================== Skyport Options: 1) Install Skyport Panel 2) Install Daemon (wings) 3) Start Panel 4) Start Daemon 5) Back ====================="
    read -p "Enter your choice [1-5]: " skyport_choice
    case $skyport_choice in
      1)
        echo_message "Installing Skyport Panel..."
        bash <(curl -s https://raw.githubusercontent.com/JishnuTheGamer/Vps/refs/heads/main/skyport)
        echo_message "Skyport Panel installation completed!"
        prompt_daemon
        ;;
      2)
        echo_message "Installing Daemon (wings)..."
        bash <(curl -s https://raw.githubusercontent.com/JishnuTheGamer/Vps/refs/heads/main/daemon)
        echo_message "Daemon (wings) installation completed!"
        ;;
      3)
        echo_message "Starting Panel..."
        cd panel && cd panel && node .
        echo_message "Panel has been started!"
        ;;
      4)
        echo_message "Starting Daemon..."
        cd daemon && cd daemon && node .
        echo_message "Daemon has been started!"
        ;;
      5) return ;;  # Back to panel menu
      *) echo -e "${RED}Invalid selection. Try again.${NC}" ;;
    esac
  done
}

# Function to prompt for daemon installation after panel install
function prompt_daemon {
  echo -e "${YELLOW}Do you want to install the daemon (wings)? (yes/no): ${NC}"
  read install_daemon
  if [[ "$install_daemon" == "yes" || "$install_daemon" == "y" ]]; then
    echo_message "Installing Daemon (wings)..."
    bash <(curl -s https://raw.githubusercontent.com/JishnuTheGamer/Vps/refs/heads/main/daemon)
    echo_message "Daemon (wings) installation completed!"
  else
    echo_message "Daemon (wings) installation skipped."
  fi
}

# Start the script with the main menu
main_menu
