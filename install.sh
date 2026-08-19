#!/usr/bin/env bash

#--------------------#
#   Initialisation   #
#--------------------#

CURRENT_USERNAME='jon1games'

RESET=$(tput sgr0)
WHITE=$(tput setaf 7)
BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
BRIGHT=$(tput bold)
UNDERLINE=$(tput smul)

OK="[${GREEN}OK${RESET}]\t"
INFO="[${BLUE}INFO${RESET}]\t"
WARN="[${MAGENTA}WARN${RESET}]\t"
ERROR="[${RED}ERROR${RESET}]\t"

set -e

#------------------------------#
#   Check if running as root   #
#------------------------------#

if [[ $EUID -eq 0 ]]; then
    echo -e "${ERROR}This script should ${RED}NOT${RESET} be executed as root!"
    echo -e "${INFO}Exiting..."
    exit 1
fi

#------------------------------------#
#   Check if whiptail is installed   #
#------------------------------------#

if ! command -v whiptail &> /dev/null; then
    echo -e "${INFO}whiptail not found, downloading required packages"
    nix-shell -p newt --run "$(realpath "$0")"
    exit $?
fi

#---------------------#
#   Greating banner   #
#---------------------#

clear

echo -E "$CYAN
     _   _ _       ___        ___           _        _ _           
    | \ | (_)_  __/ _ \ ___  |_ _|_ __  ___| |_ __ _| | | ___ _ __ 
    |  \| | \ \/ / | | / __|  | || '_ \/ __| __/ _' | | |/ _ \ '__|
    | |\  | |>  <| |_| \__ \  | || | | \__ \ || (_| | | |  __/ |   
    |_| \_|_/_/\_\\\\___/|___/ |___|_| |_|___/\__\__,_|_|_|\___|_| 
"

#------------------#
#   Get username   #
#------------------#

while true; do
    username=$(whiptail --inputbox "Enter your username:" 9 40 --title "Username" 3>&1 1>&2 2>&3)

    if [ $? != 0 ]; then
        exit 1
    fi

    if ! [[ $username =~ ^[a-z][a-z0-9_-]{0,31}$ ]]; then
        whiptail --msgbox "Invalid username: '$username'" 8 40 --title Error 3>&1 1>&2 2>&3
        continue
    fi

    if (whiptail --yesno "Use '$username' as username?" 8 40 --title "Confirm Username"); then
        break
    fi
done

#---------------------#
#   Choose hostname   #
#---------------------#

while true; do
    HOST=$(whiptail --inputbox "Enter Hostname:" 9 40 --title "Hostname" 3>&1 1>&2 2>&3)

    if [ $? != 0 ]; then
        exit 1
    fi

    if (whiptail --yesno "Use the '$HOST' host?" 8 40 --title "Confirm Host"); then
        break
    fi
done

#---------------------------------------#
# Check if host config exists or create #
#---------------------------------------#

HOST_DIR="./hosts/$HOST"

if [ -d "$HOST_DIR" ]; then
    echo "Found existing configuration for '$HOST' in $HOST_DIR."
else
    echo "Configuration for '$HOST' does not exist."
    
    if (whiptail --yesno "Would you like to create a new configuration for '$HOST' from a preset?" 9 50 --title "New Host Configuration"); then
        
        # Choose preset
        while true; do
            PRESET=$(whiptail --radiolist "Choose a preset for '$HOST':" 11 48 2 \
                "desktop" "Desktop configuration" ON \
                "laptop" "Laptop configuration" OFF \
                --title "Preset" 3>&1 1>&2 2>&3)

            if [ $? != 0 ]; then
                exit 1
            fi

            if (whiptail --yesno "Use the '$PRESET' preset?" 8 40 --title "Confirm Preset"); then
                break
            fi
        done

        # Create directory and copy preset
        PRESET_DIR="./hosts/_presets/$PRESET" # Adjust this path to where your presets are stored
        
        if [ -d "$PRESET_DIR" ]; then
            mkdir -p "$HOST_DIR"
            cp -r "$PRESET_DIR"/. "$HOST_DIR/"
            echo "Created '$HOST_DIR' using the '$PRESET' preset."
        else
            echo "Error: Preset directory '$PRESET_DIR' not found!"
            exit 1
        fi
    else
        echo "Exiting. Host configuration is required."
        exit 1
    fi
fi

#---------------------------#
#   Recap of user choices   #
#---------------------------#

SUMMARY="\
Username:   $username
Host:       $HOST
"

whiptail --msgbox "$SUMMARY" 11 40 --title "Installation Summary"

#-----------------------#
#   Last Confirmation   #
#-----------------------#

if ! (whiptail --yesno "You are about to build the system for host '$HOST'. Proceed?" 9 40 --title "Final Confirmation"); then
    exit 0
fi

#---------------------#
#   Change username   #
#---------------------#

find ./hosts ./modules flake.nix -type f -exec sed -i -e "s/${CURRENT_USERNAME}/${username}/g" {} +

#----------------------#
#   Clear git config   #
#----------------------#

echo -e "${INFO}Clearing git config"
sed -i 's/"Jon1Games"/""/g' modules/home/git.nix
sed -i 's/"118659471+Jon1Games@users.noreply.github.com"/""/g' modules/home/git.nix

#------------------------------#
#   Prepare the environement   #
#------------------------------#

## Create common dirrectories
echo -e "${INFO}Preparing the environment"
for dir in ~/documents ~/backgrounds ~/projects; do
    echo -e "${INFO}Creating folder: ${MAGENTA}${dir}${RESET}"
    mkdir -p "$dir"
done

## Get the hardware configuration
if [ ! -f /etc/nixos/hardware-configuration.nix ]; then
    echo -e "${ERROR} ${MAGENTA}/etc/nixos/hardware-configuration.nix${RESET} not found! Aborting."
    whiptail --msgbox "/etc/nixos/hardware-configuration.nix not found! Aborting." 9 40 --title "Error"
    exit 1
fi
echo -e "${INFO}Copying ${MAGENTA}/etc/nixos/hardware-configuration.nix${RESET} to ${MAGENTA}./hosts/${HOST}/${RESET}"
cp /etc/nixos/hardware-configuration.nix hosts/${HOST}/hardware-configuration.nix

#------------------#
#   Installation   #
#------------------#

echo -e "${INFO}Starting system build... this may take a while."
sudo nixos-rebuild switch --flake .#${HOST}

echo -e "${INFO}System build finished successfully"
echo -e "${INFO}You can now reboot to apply the config"
