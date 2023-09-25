#!/bin/bash

# Le script demande quel dossier l'utilisateur souhaite sauvegarder / Si le dossier n'existe pas, il affiche un message d'erreur

demande_dossier() {
  read -p "Veuillez entrer le chemin complet du dossier à sauvegarder : " dossier_source
  if [ ! -d "$dossier_source" ]; then
    echo "Le dossier n'existe pas."
    exit 1
  fi
}

# Le script demande ensuite où sauvegarder le fichier

demande_chemin_sauvegarde() {
  read -p "Veuillez entrer le chemin complet de l'endroit où sauvegarder le fichier : " chemin_sauvegarde
}

# Le script demande confirmation de sauvegarder à l'endroit choisit.

demande_confirmation() {
  read -p "Confirmez-vous la sauvegarde du dossier '$dossier_source' à l'endroit '$chemin_sauvegarde' ? (Y/N) " confirmation
  if [ "$confirmation" != "Y" ] && [ "$confirmation" != "y" ]; then
    echo "Sauvegarde annulée."
    exit 1
  fi
}

# Le cas échéant, le script créé le dossier.

creer_dossier_sauvegarde() {
  if [ ! -d "$chemin_sauvegarde" ]; then
    mkdir -p "$chemin_sauvegarde"
  fi
}

# Fonction de sauvegarde
effectuer_sauvegarde() {
  cp -r "$dossier_source" "$chemin_sauvegarde"
}

# Boucle
while true; do
  demande_dossier
  demande_chemin_sauvegarde
  demande_confirmation
  creer_dossier_sauvegarde
  effectuer_sauvegarde
  echo "Sauvegarde terminée avec succès."
  read -p "Voulez-vous sauvegarder un autre dossier ? (Y/N) " autre_sauvegarde
  if [ "$autre_sauvegarde" != "Y" ] && [ "$autre_sauvegarde" != "y" ]; then
    echo "Fin du programme."
    exit 0
  fi
done
