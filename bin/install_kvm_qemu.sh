#!/bin/bash

# script qui configure et installe une vm windows avec kvm et qemu
# TODO: étape de validation de l'image windows.

#iso_path = ""$HOME"/Downloads/Win10_22H2_English_x64v1.iso"

set -e

# Vérification des droits root
if [[ $EUID -ne 0 ]]; then
  echo "Ce script doit être exécuté avec des privilèges root. Essayez 'sudo $0'."
  exit 1
fi

# tester la vérification que le iso de windows existe
#if [[ ! -d "$iso_path" ]]; then 
#  echo "l'image de la vm existe pas"
#  exit 1
#fi

# Mettre à jour le système
echo "Mise à jour des paquets..."
apt update && apt upgrade -y || { echo "erreur lors de la mise a jour "; exit 1; }

# Vérifier si la virtualisation matérielle est supportée
echo "Vérification de la virtualisation matérielle..."
if grep -E -c '(vmx|svm)' /proc/cpuinfo > /dev/null; then
  echo "Virtualisation matérielle détectée !"
else
  echo "Erreur : La virtualisation matérielle n'est pas activée ou non supportée par votre CPU."
  exit 1
fi

# Installer KVM, QEMU et les outils nécessaires
echo "Installation des paquets KVM, QEMU et virt-manager..."
apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager ovmf || { echo "erreur lors de Installation des paquets KVM" ; exit 1; }

# Activer et démarrer le service libvirt
echo "Activation et démarrage de libvirtd..."
systemctl enable --now libvirtd || { echo "erreur lors de l'Activation et démarrage "; exit 1; }

# Ajouter l'utilisateur actuel au groupe libvirt
echo "Ajout de l'utilisateur actuel au groupe 'libvirt'..."
usermod -aG libvirt $(whoami) || { echo "erreur lors de groupe 'libvirt'"; exit 1; }

# Création d'une image disque pour le VM
read -p "Chemin du disque virtuel à créer (par défaut: ~/windows.qcow2) : " disk_path
disk_path=${disk_path:-"$HOME"/windows.qcow2}
read -p "Taille du disque virtuel en Go (par défaut: 50) : " disk_size
disk_size=${disk_size:-50}

echo "Création du disque virtuel de $disk_size Go à $disk_path..."
qemu-img create -f qcow2 "$disk_path" "${disk_size}G" || { echo "erreur lors de Création du disque virtuel de $disk_size "; exit 1; }

# Configurer le VM
echo "Configuration de la machine virtuelle..."
virt-install \
  --name windows10 \
  --ram 4096 \
  --vcpus 4 \
  --cpu host \
  --os-variant win10 \
  --disk path="$disk_path",format=qcow2 \
  --cdrom ""$HOME"/Downloads/Win10_22H2_English_x64v1.iso" \
  --network network=default,model=virtio \
  --graphics spice \
  --sound ich9 \
  --boot uefi

echo "Installation et configuration terminées"

