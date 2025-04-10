#!/bin/bash

# Usage: create_repo.sh <repository-name>

# CONFIGURATION **entrer votre user git**
github_username="hamoncode"
repository_name="$1"

# Initialize Git repository
git init
git branch -m main

# premier commit
touch README.md
git add .
git commit -m "Initial commit" 

# Creer repo sur GitHub
gh repo create "$github_username/$repository_name" --private --confirm 

# ajouter GitHub comme remote avec https
git remote add origin "https://github.com/$github_username/$repository_name.git"

# Push dans GitHub
git push -u origin main 

# message de reussite
echo "operation reussi"

