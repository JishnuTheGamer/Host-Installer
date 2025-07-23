#!/bin/bash

# Define colors
BG_BLACK="\e[40m"
BG_RED="\e[41m"
BG_GREEN="\e[42m"
BG_YELLOW="\e[43m"
BG_BLUE="\e[44m"
BG_MAGENTA="\e[45m"
BG_CYAN="\e[46m"
BG_WHITE="\e[47m"

BRIGHT_BLACK="\e[90m"
BRIGHT_RED="\e[91m"
BRIGHT_GREEN="\e[92m"
BRIGHT_YELLOW="\e[93m"
BRIGHT_BLUE="\e[94m"
BRIGHT_MAGENTA="\e[95m"
BRIGHT_CYAN="\e[96m"
BRIGHT_WHITE="\e[97m"

GREEN="\e[32m"
YELLOW="\e[33m"
CYAN="\e[36m"
RED="\e[31m"
RESET="\e[0m" # Reset all styles
NC="$RESET"   # Alias for RESET (fixed missing NC)

# Styles
BOLD="\e[1m"
DIM="\e[2m"
UNDERLINE="\e[4m"
BLINK="\e[5m"
REVERSE="\e[7m"
HIDDEN="\e[8m"

# Simple spinner function for loading animations
spinner() {
    local pid=$1
    local delay=0.1
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}${BOLD}Error: Please run this script as root (use sudo).${NC}"
  exit 1
fi

# Clear the terminal
clear

# Fancy ASCII Art Header
echo -e "${BG_CYAN}${BRIGHT_WHITE}${BOLD}"
echo "  ____          _   _   ___          _     _          _     _             "
echo " |  _ \   __ _ | \ | | |_ _|  _ __  | |   (_)  __ _  | |_  | |   ___   _ __ "
echo " | |_) | / _\` ||  \| |  | |  | '_ \ | |   | | / _\` | | __| | |  / _ \ | '__|"
echo " |  __/ | (_| || |\  |  | |  | | | || |___| || (_| | | |_  | | | (_) || |   "
echo " |_|     \__,_||_| \_| |___| |_| |_||_____||_| \__,_|  \__| |_|  \___/ |_|   "
echo -e "${NC}"
echo -e "${CYAN}${UNDERLINE}${BOLD}        Panel Installer by Joy (N!GHT .EXE)        ${NC}"
echo -e "${YELLOW}${BOLD}Credits: Jishnu & Joy${NC}"
echo -e "${CYAN}=====================================================${NC}"

# Menu options
echo -e "${YELLOW}${BOLD}Select an Option:${NC}"
echo -e "${GREEN}${BOLD}--------------------- Install Panels -------------------------${NC}"
echo -e "${GREEN}1)${NC} Install Pterodactyl (Panel + Wings with IP on VPS or VM)"
echo -e "${GREEN}2)${NC} Install Skyport Panel (Panel + Wings for Ubuntu/Debian)"
echo -e "${GREEN}3)${NC} Install Draco Panel"
echo -e "${GREEN}4)${NC} Install PufferPanel (All-in-One for GitHub Codespace/VPS)"
echo -e "${GREEN}5)${NC} Install PowerPort Panel"
echo -e "${GREEN}6)${NC} More panels coming soon..."
echo -e "${GREEN}${BOLD}--------------------- Install Dashboard ----------------------${NC}"
echo -e "${GREEN}7)${NC} Install Dashboard"
echo -e "${GREEN}${BOLD}--------------------- Install Daemon ------------------------${NC}"
echo -e "${GREEN}8)${NC} Install Daemon (for options 3,4,6,7 if not installed)"
echo -e "${CYAN}=====================================================${NC}"
echo -n -e "${BRIGHT_YELLOW}${BOLD}Enter your choice (1-8): ${NC}"
read -r choice

# Confirmation prompt
echo -e "${YELLOW}${BOLD}Are you sure you want to proceed with option $choice? (y/n): ${NC}"
read -r confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
  echo -e "${RED}${BOLD}Installation cancelled.${NC}"
  exit 0
fi

# Run the selected installation script with spinner
case $choice in
    1)
        echo -e "${GREEN}${BOLD}Installing Pterodactyl...${NC}"
        (bash <(curl -fsSL https://raw.githubusercontent.com/spookyMC123/panel-installer/main/script/ptrodactyl/install.sh)) &
        spinner $!
        ;;
    2)
        echo -e "${GREEN}${BOLD}Installing Skyport Panel...${NC}"
        (bash <(curl -fsSL https://raw.githubusercontent.com/spookyMC123/panel-installer/main/script/skyport/installer.sh)) &
        spinner $!
        ;;
    3)
        echo -e "${GREEN}${BOLD}Installing Draco Panel...${NC}"
        (bash <(curl -fsSL https://raw.githubusercontent.com/spookyMC123/panel-installer/main/script/draco-v1/installer.sh)) &
        spinner $!
        ;;
    4)
        echo -e "${GREEN}${BOLD}Installing PufferPanel...${NC}"
        (bash <(curl -fsSL https://raw.githubusercontent.com/spookyMC123/panel-installer/main/script/puffer%20panel/installpuffer.sh)) &
        spinner $!
        ;;
    5)
        echo -e "${GREEN}${BOLD}Installing PowerPort Panel...${NC}"
        (bash <(curl -fsSL https://raw.githubusercontent.com/spookyMC123/panel-installer/main/script/powerport/install.sh)) &
        spinner $!
        ;;
    6)
        echo -e "${YELLOW}${BOLD}Sorry, more panels are coming soon! Stay tuned.${NC}"
        echo -e "${BG_MAGENTA}${BRIGHT_WHITE}----------------------------${NC}"
        echo -e "${RED}${BOLD}Exiting in 5 seconds...${NC}"
        sleep 5
        exit 0
        ;;
    7)
        echo -e "${GREEN}${BOLD}Installing Dashboard...${NC}"
        (bash <(curl -fsSL https://raw.githubusercontent.com/spookyMC123/panel-installer/main/script/DashBoad/install.sh)) &
        spinner $!
        ;;
    8)
        echo -e "${GREEN}${BOLD}Installing Daemon...${NC}"
        (bash <(curl -fsSL https://raw.githubusercontent.com/spookyMC123/panel-installer/main/script/deamon/install.sh)) &
        spinner $!
        ;;
    *)
        echo -e "${RED}${BOLD}Invalid choice! Please run the script again and select a valid option.${NC}"
        exit 1
        ;;
esac

echo -e "${GREEN}${BOLD}Panel Installer process completed successfully!${NC}"
echo -e "${CYAN}=====================================================${NC}"
echo -e "${YELLOW}${BOLD}Thank you for using the installer. Credits: Jishnu & Joy${NC}"
