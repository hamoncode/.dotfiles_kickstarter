#!/bin/bash

nombre=$1
nom=$2

# checkup 1
if [ $# -ne 2 ]; then
  echo "veuilliez entrez deux arguments (nombre/nom)"
  exit 1
fi 

# checkup 2
if ! [[ $nombre =~ ^[0-9]+$ ]]; then
  echo "veuilliez entrer seulement des chiffres dans le premier argument"
  exit 1
fi

# checkup 3

if ! [[ $nom =~ ^[a-z]+$ ]]; then
  echo "veuilliez entrer seulement des lettres dans le deuxieme argument"
  exit 1
fi

# fonction qui fait plusieur mkdir à la fois

createMkdir() {
  for ((i = 1; i <= $nombre; i++)); do
    mkdir -p "$nom$i"
  done
  echo "$nombre repos créé"
}
createMkdir
