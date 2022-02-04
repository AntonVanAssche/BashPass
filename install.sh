#!/bin/bash

# Abort the script when an error occures.
set -e

currentDir="$(pwd)"

configLocation="$HOME/.config/bashpass"
config="$configLocation/bashpass.conf"
oldVersion="$(grep "version" "$config" | cut -d: -f2)"
newVersion="$(grep "version" "$currentDir/config/bashpass.conf" | cut -d: -f2)"

# Detect user
if [[ "$UID" == 0 ]]; then
   prinf "You must run this as a normal user"
   exit 1
fi

function Update() {
   printf "BashPass is already installed on your system"
   printf "\nUpdating BashPass..."

   sed -i "1s|$oldVersion|$newVersion|g" "$config"
   cp -r "$currentDir/bashpass" "$HOME/.local/bin/bashpass"
}

function Install() {
   printf "Installing BashPass..."
   mkdir -p "$HOME/.config/bashpass"
   mkdir -p "$HOME/.local/share/bashpass"

   cp -r "$currentDir/config/bashpass.conf" "$HOME/.config/bashpass/bashpass.conf"
   cp -r "$currentDir/bashpass" "$HOME/.local/bin/bashpass"

   printf "\nMake sure to add '\$HOME/.local/bin/' to your \$PATH."
}

if [[ -f $HOME/.local/bin/bashpass ]]; then
   Update
else
   Install
fi
