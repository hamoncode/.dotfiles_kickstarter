#!/bin/bash

# Fichier contenant la liste des packages Homebrew
PACKAGE_BREW="packageBrew.txt"

# Chemin du script (pour créer les symlinks)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Vérification de la présence du fichier packagesBrew.txt
if [ ! -f "$PACKAGE_BREW" ]; then
  echo "Error: $PACKAGE_BREW not found"
  exit 1
fi

# Lire le contenu de packagesBrew.txt
PackagesBrew=$(cat "$PACKAGE_BREW")

# Vérifier la présence de Homebrew
if ! command -v brew &> /dev/null; then
  echo "Error: Homebrew (brew) is not installed on this system."
  echo "Please install Homebrew first: https://brew.sh/"
  exit 1
fi

# Mise à jour de Homebrew et upgrade des paquets
echo "Updating Homebrew..."
brew update || { echo "Error updating Homebrew"; exit 1; }
echo "Upgrading installed packages..."
brew upgrade || { echo "Error upgrading Homebrew packages"; exit 1; }

# Installation des packages Homebrew
echo "Installing Homebrew packages..."
for package in $PackagesBrew; do
  brew install "$package" || { echo "Error installing $package"; exit 1; }
done

# Sous-script pour installer oh-my-zsh
echo "Installing Oh My Zsh..."
echo "Exit the subscript with 'exit' once setup is complete."
echo "Sorry, didn't find a better fix yet."
echo "....."
echo "....."
echo "DON'T FORGET, type exit and press enter to exit the subscript when setup is done!"

# Installation via curl (si wget pas installé, par ex.)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || { echo "Error installing Oh My Zsh"; exit 1; }

