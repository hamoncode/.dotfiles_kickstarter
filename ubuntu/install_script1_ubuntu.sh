#!/bin/sh

# fichiers à parser
PACKAGE_APT="packageApt.txt"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# vérification que les fichiers se trouvent dans le repo
if [[ ! -f "$PACKAGE_APT" ]]; then
  echo "error: $PACKAGE_APT not found"
  exit 1
fi

# parser avec cat les fichiers
PackagesApt=$(cat "$PACKAGE_APT")

# Update and upgrade
echo "Updating and upgrading apt package lists..."
sudo apt update || { echo "Error updating apt packages"; exit 1; }
sudo apt upgrade || { echo "Error upgrading apt packages"; exit 1; }

# Install apt packages
echo "Installing apt packages..."
for package in $PackagesApt; do
  sudo apt install -y "$package" || { echo "Error installing $package"; exit 1; }
done

# Update pour s'assurer tous les packages sont à jours
echo "Updating package lists..."
sudo apt update || { echo "Error updating Apt packages"; exit 1; }
sudo apt upgrade || { echo "Error upgrading Apt packages";exit 1; } 

sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" || { echo "Error installing Oh My Zsh"; exit 1; }

