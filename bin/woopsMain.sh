#!/bin/bash

# Check if a branch name was provided
if [ -z "$1" ]; then
  echo "Usage: $0 <branch-name>"
  exit 1
fi

BRANCH="$1" 

# stash your change

git stash -u || { echo "Failed to stash change"; exit 1; }

# checkout to your working branch

git checkout "$BRANCH" || { echo "failed to checkout $BRANCH"; exit1; }

# apply change before commiting

git stash apply || { echo "failed apply changes"; exit1 ; }

# message de reussite

echo "changement appliqué avec succès"


