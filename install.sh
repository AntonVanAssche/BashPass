#!/bin/bash

# Abort the script when an error occures.
set -e

currentDir="$(pwd)"

configLocation="$HOME/.config/bashpass"
config="$configLocation/bashpass.conf"

# Detect user
if [[ "$UID" == 0 ]]; then
   prinf "You must run this as a normal user"
   exit 1
fi

function Update() {
   local oldVersion newVersion
   oldVersion="$(grep "version" "$config" | cut -d: -f2)"
   newVersion="$(grep "version" "$currentDir/config/bashpass.conf" | cut -d: -f2)"

   printf "BashPass is already installed on your system"
   printf "\nUpdating BashPass to version: %s..." "${newVersion}"

   sed -i "1s|$oldVersion|$newVersion|g" "$config"
   cp -r "$currentDir/bashpass" "$HOME/.local/bin/bashpass"
}

function Install() {
   if [[ -f "$HOME/.local/bin/bashpass" ]]; then
      Update
      exit
   fi

   printf "Installing BashPass..."
   mkdir -p "$HOME/.config/bashpass"
   mkdir -p "$HOME/.local/share/bashpass"

   cp -r "$currentDir/config/bashpass.conf" "$HOME/.config/bashpass/bashpass.conf"
   cp -r "$currentDir/bashpass" "$HOME/.local/bin/bashpass"

   printf "\nMake sure to add '\$HOME/.local/bin/' to your \$PATH."
}

function Uninstall() {
   printf "Uninstalling BashPass..."
   rm -rf "$HOME/.config/bashpass" "$HOME/.local/share/bashpass" "$HOME/.local/bin/bashpass"
   printf "\n"
   printf "We hate to see you go."
}

function Main() {
   case "$1" in
      "--install") Install;;
      "--update") Update;;
      "--uninstall") Uninstall;;
      *) printf "option '%s' not found" "${1}";;
   esac
}

Main "$1"
