#!/bin/bash

# Installer GUI Script for Draco Panel
# This script provides a graphical interface for installing the Draco Panel.
# Author: [Your Name or GitHub Handle]

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
    echo "Starting installation of Draco Panel..."
    
    # Run the installation command
    bash <(curl -s https://raw.githubusercontent.com/JishnuTheGamer/Panel-Installer/main/Script/Draco%20panel) 2>&1 | while read line; do
      echo "$line" # Output the installation log
      sleep 1 # Simulate time taken for each line (adjust as necessary)
      echo "100" # Final percentage
    done
  ) | zenity --progress --title="Installing Draco Panel" --text="Starting installation..." --percentage=0 --auto-close --width=400 --height=200
}

# Main GUI Loop
while true; do
  PANEL=$(zenity --list --title="Panel Installer" \
    --column="Select a Panel" \
    "Draco Panel" \
    "Exit")

  # Check if the user selected "Exit"
  if [ "$PANEL" == "Exit" ]; then
    break
  fi

  # Run the installation for Draco Panel
  case $PANEL in
    "Draco Panel")
      # Show progress bar and run the installation
      if show_progress; then
        show_info "Draco Panel installation completed successfully!"
      else
        show_error "Failed to install Draco Panel."
      fi
      ;;
    *)
      show_error "Invalid selection."
      ;;
  esac
done

show_info "Thank you for using the Panel Installer!"
