#!/bin/bash

Abort the script when an error occures.
set -e

currentDir="$(pwd)"

# Detect user
if [[ "$UID" == 0 ]]; then
   prinf "You must run this as a normal user"
   exit 1
fi

mkdir -p "$HOME/.config/bashpass"
mkdir -p "$HOME/.local/share/bashpass"

cp -r "$currentDir/config/bashpass.conf" "$HOME/.config/bashpass/bashpass.conf"
cp -r "$currentDir/bashpass" "$HOME/.local/bin/bashpass"

printf "Make sure to add '\$HOME/.local/bin/' to your \$PATH."