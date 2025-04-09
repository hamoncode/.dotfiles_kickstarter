#!/bin/bash

# symlink .zshrc
if [ -f ~/.zshrc ]; then
    cp ~/.zshrc ~/.zshrc.bak || { echo "Erreur: impossible de sauvegarder .zshrc"; exit 1; }
    rm -f ~/.zshrc || { echo "Erreur: impossible de supprimer .zshrc"; exit 1; }
fi
ln -s $SCRIPT_DIR/.zshrc ~/.zshrc || { echo "Erreur: problème lors de la création du symlink pour .zshrc"; exit 1; }

# Clone external plugins (Quickfix)
# pluggin terminal autosuggestion
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions || { echo "Erreur: problème lors du clonage de zsh-autosuggestions"; exit 1; }

# pluggin terminal syntax highlight
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting || { echo "Erreur: problème lors du clonage de zsh-syntax-highlighting"; exit 1; }

# pluggin terminal autocomplete
git clone https://github.com/marlonrichert/zsh-autocomplete.git || { echo "Erreur: problème lors du clonage de zsh-autocomplete"; exit 1; }

# fix manuel du dernier pluggin (Quickfix)
mv ./zsh-autocomplete ~/.oh-my-zsh/plugins || { echo "erreur durant le fix zsh-autocomplete"; exit 1; }

echo "Installations et Configurations réussi!"

