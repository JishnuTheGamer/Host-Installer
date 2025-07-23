#!/bin/bash

# Installer GUI Script for Draco and Skyport Panels
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
        show_info "Draco Panel installation completed successfully!"
      else
        show_error "Failed to install Draco Panel."
      fi
      ;;
    "Skyport Panel")
      if show_progress "skyport"; then
        show_info "Skyport Panel installation completed successfully!"
      else
        show_error "Failed to install Skyport Panel."
      fi
      ;;
    *)
      show_error "Invalid selection."
      ;;
  esac
done

show_info "Thank you for using the Panel Installer!"
