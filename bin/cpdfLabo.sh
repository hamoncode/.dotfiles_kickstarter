#!/bin/bash

# Chemin vers le fichier template
template_file="$HOME/.dotfiles/bin/templates/pdgTemplate.md"

# Vérification des arguments
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <fichier_markdown_à_ajouter> <fichier_sortie>"
  exit 1
fi

# Assignation des arguments à des variables
markdown_file="$1"
output_file="$2"

# Vérification de l'existence du fichier de template
if [ ! -f "$template_file" ]; then
  echo "Erreur : Le fichier de template '$template_file' n'existe pas."
  exit 1
fi

# Vérification de l'existence du fichier Markdown à ajouter
if [ ! -f "$markdown_file" ]; then
  echo "Erreur : Le fichier Markdown à ajouter '$markdown_file' n'existe pas."
  exit 1
fi

# Concatenation des fichiers
cat "$template_file" "$markdown_file" > "$output_file"

cpdf_pretty_script="$HOME/.dotfiles/bin/cpdfpretty.sh"

"$cpdf_pretty_script" "$output_file" || { echo "error de convertion pdf"; exit 1; }

rm "$output_file" || { echo "erreur lors de l'effacement du fichier output"; exit 1; }

echo "le fichier pdf de laboratoire a été créé avec succès"

