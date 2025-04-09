#!/bin/bash

# Création du symlink pour .zshrc
if [ -f ~/.zshrc ]; then
    echo "Backing up existing ~/.zshrc to ~/.zshrc.bak ..."
    cp ~/.zshrc ~/.zshrc.bak || { echo "Error: unable to back up .zshrc"; exit 1; }
    rm -f ~/.zshrc || { echo "Error: unable to remove existing .zshrc"; exit 1; }
fi

echo "Creating symlink for .zshrc ..."
ln -s "$SCRIPT_DIR/.zshrc" ~/.zshrc || { echo "Error creating symlink for .zshrc"; exit 1; }

# Installation des plugins
echo "Cloning zsh-autosuggestions plugin..."
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" || { echo "Error cloning zsh-autosuggestions"; exit 1; }

echo "Cloning zsh-syntax-highlighting plugin..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" || { echo "Error cloning zsh-syntax-highlighting"; exit 1; }

echo "Cloning zsh-autocomplete plugin..."
git clone https://github.com/marlonrichert/zsh-autocomplete.git || { echo "Error cloning zsh-autocomplete"; exit 1; }

# Déplacement du plugin dans le répertoire oh-my-zsh/plugins
echo "Moving zsh-autocomplete into ~/.oh-my-zsh/plugins ..."
mv ./zsh-autocomplete ~/.oh-my-zsh/plugins || { echo "Error moving zsh-autocomplete"; exit 1; }

echo "Installations and configurations completed successfully on macOS!"


