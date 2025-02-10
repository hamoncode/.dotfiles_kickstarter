#!/bin/bash

# Define the name of the Node.js project and the directory (argument 1 = name)
ENV_NAME=jsEnv
ENV_DIR="$HOME/.venvs/$ENV_NAME"
PACKAGE_JSON_PATH="$HOME/.dotfiles/bin/package.json"

# Ensure Node.js and npm are installed
if ! command -v node &> /dev/null || ! command -v npm &> /dev/null; then
  echo "Node.js n'est pas installé. Installation de Node.js..."
  sudo pacman -S --noconfirm nodejs npm  # Arch Linux command to install Node.js and npm
  echo "Node.js et npm installés avec succès."
else
  echo "Node.js et npm sont déjà installés."
fi

# Create the project directory if it doesn't exist
if [ ! -d "$ENV_DIR" ]; then
  echo "Création du projet Node.js..."
  mkdir -p "$ENV_DIR"
  echo "Projet créé à $ENV_DIR."
else
  echo "Le projet Node.js existe déjà."
fi

# Copy the package.json file
echo "Copie du fichier package.json..."
ln -sf "$PACKAGE_JSON_PATH" "$ENV_DIR/package.json"  # Use -sf to force link

# Change to the project directory
cd "$ENV_DIR" || { echo "Échec de la navigation vers $ENV_DIR"; exit 1; }

# Install Node.js dependencies if package.json exists
if [ -f "package.json" ]; then
  echo "Installation des dépendances Node.js..."
  npm install
  echo "Installation des dépendances terminée."
else
  echo "Aucun fichier package.json trouvé à $ENV_DIR"
fi

# Optionally, create the package-lock.json and fix vulnerabilities
npm i --package-lock-only
npm audit fix

echo "Configuration terminée."

