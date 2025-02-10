#!/bin/bash

# Vérifier si le chemin du répertoire et le nom du fichier de sortie ont été fournis en argument
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 chemin_du_répertoire fichier_de_sortie.pdf"
    exit 1
fi

# Définir le chemin vers le dossier contenant les dossiers de cours à partir de l'argument
base_dir="$1"
output_file="$2"

# Créer une liste des fichiers PDF à fusionner
pdf_files=()

# Boucler sur chaque dossier de lecture trouvé dans le répertoire de base
for lecture_dir in "$base_dir"/lecture*; do
    # Chercher tous les fichiers PDF dans le dossier de lecture
    for pdf_file in "$lecture_dir"/*.pdf; do
        # Vérifier si des fichiers PDF existent
        if [ -f "$pdf_file" ]; then
            echo "Ajout de $pdf_file à la liste des fichiers à fusionner"
            pdf_files+=("$pdf_file")
        fi
    done
done

# Fusionner les fichiers PDF en utilisant pdftk
if [ ${#pdf_files[@]} -gt 0 ]; then
    pdftk "${pdf_files[@]}" cat output "$output_file"
    echo "Fusion terminée. Fichier final: $output_file"
else
    echo "Aucun fichier PDF trouvé."
fi

