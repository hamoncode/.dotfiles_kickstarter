#!/bin/sh

# fichiers à parser
PACKAGE_APT="packageApt.txt"
PACKAGE_SNAP="packageSnap.txt"

# vérification que les fichiers se trouvent dans le repo
if [[ ! -f "$PACKAGE_APT" ]]; then
  echo "error: $PACKAGE_APT not found"
  exit 1
fi

if [[ ! -f "$PACKAGE_SNAP" ]]; then
  echo "error: $PACKAGE_SNAP not found"
  exit 1
fi

# parser avec cat les fichiers
PackagesApt=$(cat "$PACKAGE_APT")
PackagesSnap=$(cat "$PACKAGE_SNAP")

# Update and upgrade
echo "Updating and upgrading apt package lists..."
sudo apt update || { echo "Error updating apt packages"; exit 1; }

sudo apt upgrade || { echo "Error upgrading apt packages"; exit 1; }

# Install apt packages
echo "Installing apt packages..."
for package in $PackagesApt; do
  sudo apt install -y "$package" || { echo "Error installing $package"; exit 1; }
done

# Install snap packages
#echo "Installing snap packages..."
#for package in $PackagesSnap; do
#  sudo snap install -y "$package" || { echo "Error installing $package"; exit 1; }
#done

# Update pour s'assurer tous les packages sont à jours
echo "Updating package lists..."
sudo apt update || { echo "Error updating Apt packages"; exit 1; }

# manual installations
# pour les packages qui sont pas a jour 

# 1) kitty 
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin launch=n

# 2) picom 
# Debian specific command. The next few commands are for all distros
sudo apt install libconfig-dev libdbus-1-dev libegl-dev libev-dev libgl-dev libepoxy-dev libpcre2-dev libpixman-1-dev libx11-xcb-dev libxcb1-dev libxcb-composite0-dev libxcb-damage0-dev libxcb-glx0-dev libxcb-image0-dev libxcb-present-dev libxcb-randr0-dev libxcb-render0-dev libxcb-render-util0-dev libxcb-shape0-dev libxcb-util-dev libxcb-xfixes0-dev meson ninja-build uthash-dev
# clone the project and go into it
git clone https://github.com/yshui/picom && cd picom
# Use the meson build system (written in python), to make a ninja build 
$ meson setup --buildtype=release build
$ ninja -C build
# Copy the resultant binary into PATH
cp build/src /usr/local/bin

# 3) Install Oh My Zsh
# mettre a la fin du install script car lancement de zsh automatique
echo "Installing Oh My Zsh..."
sudo apt install -y zsh || { echo "Error installing zsh"; exit 1; }
echo "Please provide input for configuration of Oh My Zsh"

# subscript parce que sinon sa sort du script
(
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" || { echo "Error installing Oh My Zsh"; exit 1; }
)

# lancement du config script
# cré les symlinks approprié des dotfiles a home

# symlink .zshrc
if [ -f ~/.zshrc ]; then
    rm -f ~/.zshrc || { echo "Erreur: impossible de supprimer .zshrc"; exit 1; }
fi
ln -s ~/.dotfiles/.zshrc ~/.zshrc || { echo "Erreur: problème lors de la création du symlink pour .zshrc"; exit 1; }

# symlink .desktop shortcuts
if [ -d ~/.local/share/applications ]; then
    rm -rf ~/.local/share/applications || { echo "Erreur: impossible de supprimer le dossier applications"; exit 1; }
fi
ln -s ~/.dotfiles/applications ~/.local/share/applications || { echo "Erreur: problème lors de la création du symlink pour applications"; exit 1; }

# symlink fonts
if [ -d ~/.local/share/fonts ]; then
    rm -rf ~/.local/share/fonts || { echo "Erreur: impossible de supprimer le dossier fonts"; exit 1; }
fi
ln -s ~/.dotfiles/fonts ~/.local/share/fonts || { echo "Erreur: problème lors de la création du symlink pour fonts"; exit 1; }

# symlink .config
if [ -d ~/.config ]; then
    rm -rf ~/.config || { echo "Erreur: impossible de supprimer le dossier .config"; exit 1; }
fi
ln -s ~/.dotfiles/.config ~/.config || { echo "Erreur: problème lors de la création du symlink pour .config"; exit 1; }

# Clone external plugins (Quickfix)
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions || { echo "Erreur: problème lors du clonage de zsh-autosuggestions"; exit 1; }
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting || { echo "Erreur: problème lors du clonage de zsh-syntax-highlighting"; exit 1; }
git clone https://github.com/marlonrichert/zsh-autocomplete.git || { echo "Erreur: problème lors du clonage de zsh-autocomplete"; exit 1; }

# fix manuel du dernier pluggin (Quickfix)
mv ./zsh-autocomplete ~/.oh-my-zsh/plugins || { echo "erreur durant le fix zsh-autocomplete"; exit 1; }

echo "Configurations réussi!"
