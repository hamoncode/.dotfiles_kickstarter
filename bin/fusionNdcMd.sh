#!/bin/bash

# Vérifier si le chemin du répertoire et le nom du fichier de sortie ont été fournis en argument
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 chemin_du_répertoire fichier_de_sortie.md"
    exit 1
fi

# Définir le chemin vers le dossier contenant les dossiers de cours à partir de l'argument
base_dir="$1"
output_file="$2"

# Vider le fichier de sortie s'il existe déjà
> "$output_file"

# Boucler sur chaque dossier de lecture trouvé dans le répertoire de base
for lecture_dir in "$base_dir"/lecture*; do
    # Chercher tous les fichiers markdown dans le dossier de lecture
    for markdown_file in "$lecture_dir"/*.md; do
        # Vérifier si des fichiers markdown existent
        if [ -f "$markdown_file" ]; then
            echo "Fusion de $markdown_file dans $output_file"
            
            # Extraire le numéro de la lecture depuis le nom du dossier
            lecture_num=$(basename "$lecture_dir" | sed 's/lecture//')
            
            # Ajouter un titre pour chaque lecture (optionnel)
            echo "# Notes de Lecture $lecture_num" >> "$output_file"
            
            # Ajouter le contenu du fichier markdown au fichier de sortie
            cat "$markdown_file" >> "$output_file"
            
            # Ajouter une nouvelle ligne pour la séparation
            echo -e "\n" >> "$output_file"
        fi
    done
done

echo "Fusion terminée. Fichier final: $output_file"

