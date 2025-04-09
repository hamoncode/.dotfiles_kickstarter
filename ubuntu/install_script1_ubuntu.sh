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

# subscript pour oh my zsh parce que sinon sortie de script
echo"installing oh my zsh"
echo"exit the subscript with exit when the setup is done"
echo"sorry, didn't find a better fix yet" 
echo"....."
echo"....."
echo"DON'T FORGET, type exit and press enter to exit the subscript when setup is done!"

sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" || { echo "Error installing Oh My Zsh"; exit 1; }

