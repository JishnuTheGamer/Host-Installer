#!/bin/bash

# Installer GUI Script for Draco and Skyport Panels
# Author: [Your Name or GitHub Handle]

# Colors for terminal output
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to show an error message
function show_error {
  zenity --error --text="$1"
}

# Function to show an info message
function show_info {
  zenity --info --text="$1"
}

# Function to show a progress bar during installation
function show_progress {
  (
    echo "0" # Initial percentage
    echo "Starting installation..."

    # Run the installation command based on the panel selected
    if [ "$1" == "draco" ]; then
      bash <(curl -s https://raw.githubusercontent.com/JishnuTheGamer/Vps/refs/heads/main/jishnu) 2>&1 | while read line; do
        echo "$line" # Output the installation log
        sleep 1 # Simulate time taken for each line (adjust as necessary)
        echo "100" # Final percentage
      done
    elif [ "$1" == "skyport" ]; then
      bash <(curl -s https://raw.githubusercontent.com/JishnuTheGamer/skyport/refs/heads/main/panel) 2>&1 | while read line; do
        echo "$line" # Output the installation log
        sleep 1 # Simulate time taken for each line (adjust as necessary)
        echo "100" # Final percentage
      done
    fi
  ) | zenity --progress --title="Installing Panel" --text="Starting installation..." --percentage=0 --auto-close --width=400 --height=200
}

# Main GUI Loop
while true; do
  PANEL=$(zenity --list --title="Panel Installer" \
    --column="Select a Panel" \
    "Draco Panel" \
    "Skyport Panel" \
    "Exit")

  # Check if the user selected "Exit"
  if [ "$PANEL" == "Exit" ]; then
    break
  fi

  # Run the installation for the selected panel
  case $PANEL in
    "Draco Panel")
      if show_progress "draco"; then
        echo -e "${GREEN}Draco Panel installation completed successfully!${NC}"
        show_info "Draco Panel installation completed successfully!"
      else
        echo -e "${RED}Failed to install Draco Panel.${NC}"
        show_error "Failed to install Draco Panel."
      fi
      ;;
    "Skyport Panel")
      if show_progress "skyport"; then
        echo -e "${GREEN}Skyport Panel installation completed successfully!${NC}"
        show_info "Skyport Panel installation completed successfully!"
      else
        echo -e "${RED}Failed to install Skyport Panel.${NC}"
        show_error "Failed to install Skyport Panel."
      fi
      ;;
    *)
      echo -e "${RED}Invalid selection.${NC}"
      show_error "Invalid selection."
      ;;
  esac
done

echo -e "${CYAN}Thank you for using the Panel Installer!${NC}"
