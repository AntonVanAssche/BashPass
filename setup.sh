#!/bin/bash

# Abort the script when an error occures.
set -e

currentDir="$(pwd)"

configLocation="$HOME/.config/bashpass"
config="$configLocation/bashpass.conf"

# Detect user
if [[ "${UID}" == 0 ]]; then
   printf "You must run this as a normal user.\nCurrent user ID: %s %s\n" "${UID}" "$([[ "${UID}" -eq 0 ]] && printf "(root)")"
   exit 1
fi

GetLatestVersion() {
   curl --silent "https://api.github.com/repos/AntonVanAssche/BashPass/releases/latest" | # Get latest release from GitHub api
   grep '"tag_name":' |                                            # Get tag line
   sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}

CloneLatestVersion() {
   #git clone -b -q "$(basename "$(curl -Ls -o /dev/null -w "%{url_effective}" https://github.com/AntonVanAssche/BashPass/releases/latest)")" \
      # https://github.com/AntonVanAssche/BashPass.git

   # Current replacement for cloning the latest version.
   git clone https://github.com/AntonVanAssche/BashPass.git
   cd BashPass/
   git checkout develop
   cd ../
}

Install() {
   if [[ -f "${HOME}/.local/bin/bashpass" ]]; then
      Update
      exit 1
   fi

   CloneLatestVersion

   printf "Installing BashPass version: %s..." "$(GetLatestVersion)"
   mkdir -p "${HOME}/.config/bashpass"
   mkdir -p "${HOME}/.local/share/bashpass"

   cp -r "${currentDir}/BashPass/config/bashpass.conf" "${HOME}/.config/bashpass/bashpass.conf"
   cp -r "${currentDir}/BashPass/bashpass" "${HOME}/.local/bin/bashpass"

   printf "\nMake sure to add '\${HOME}/.local/bin/' to your \$PATH."

   rm -rf BashPass/
}

Uninstall() {
   printf "Uninstalling BashPass version: %s..." "$(GetLatestVersion)"
   rm -rf "${HOME}/.config/bashpass" "${HOME}/.local/share/bashpass" "${HOME}/.local/bin/bashpass"
   printf "\n"
   printf "We hate to see you go."
}

Update() {
   currentConfig="${config}.old"
   
   printf "Updating BashPass to version: %s...\n" "'$(GetLatestVersion)'"

   CloneLatestVersion

   case $(grep "version" "${config}" | cut -d: -f2) in
      "1.0"| "1.1")
         mv "${config}" "${currentConfig}"

         cp -r "${currentDir}"/BashPass/config/bashpass.conf "${config}"

         currentLocation="$(grep "location" "$currentConfig" | cut -d: -f2)"
         currentEmail="$(grep "email" "$currentConfig" | cut -d: -f2)"
         currentTimer="$(grep "timer" "$currentConfig" | cut -d: -f2)"

         printf "email: %s" "$currentEmail" >> "${config}"
         sed -i "2s|.local/share/bashpass|$currentLocation|g" "${config}"
         sed -i "3s|10|$currentTimer|g" "${config}"
         ;;
      *)
         currentVersion="$(grep "version" "${config}" | cut -d" " -f2)"
         newVersion="$(grep "version" "./BashPass/config/bashpass.conf" | cut -d" " -f2)"
         sed -i "1s|${currentVersion}|${newVersion}|g" "${config}"
         ;;
   esac

   cp -r "${currentDir}/BashPass/bashpass" "${HOME}/.local/bin/bashpass"
   rm -rf "${currentConfig}" BashPass/
}

Main() {
   case "${1}" in
      "--install") Install;;
      "--uninstall") Uninstall;;
      "--update") Update;;
      *) printf "option '%s' not found" "${1}";;
   esac
}

Main "${1}"
