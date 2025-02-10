#!/bin/bash

# Définir le nom de l'environnement virtuel et le répertoire (argument 1 = nom)
ENV_NAME=venvPython
ENV_DIR="$HOME/.venvs/$ENV_NAME"
REQUIREMENTS_PATH="$HOME/.dotfiles/bin/requirements.txt"
# Créer le répertoire s'il n'existe pas
mkdir -p $(dirname $ENV_DIR)

# Vérifier si l'environnement virtuel existe déjà
if [ -d "$ENV_DIR" ]; then
  echo "L'environnement virtuel existe déjà."
else
  echo "Création de l'environnement virtuel..."
  python -m venv $ENV_DIR
  echo "Environnement virtuel créé avec succès."
fi

# Utiliser un subshell pour garder le script en vie et installer les dépendances
(
  source $ENV_DIR/bin/activate
  echo 'L’environnement est activé'
  if [ -f "$REQUIREMENTS_PATH" ]; then
    echo 'Installation des dépendances...'
    pip install -r $REQUIREMENTS_PATH
    echo 'Installation des dépendances terminée'
  else
    echo "Aucun fichier requirements.txt trouvé à $REQUIREMENTS_PATH"
  fi
  echo "Configuration terminée."
)

