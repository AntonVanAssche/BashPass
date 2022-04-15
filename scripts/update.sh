#!/bin/bash

# Abort the script when an error occures.
set -e

currentDir="$(pwd)"

configLocation="$HOME/.config/bashpass"
config="${configLocation}/bashpass.conf"
oldConfig="${config}.old"

mv "${config}" "${oldConfig}"

currentVersion="$(grep "version" "${config}" | cut -d" " -f2)" || :
currentLocation="$(grep "location" "${oldConfig}" | cut -d: -f2)" || :
currentEmail="$(grep "email" "${oldConfig}" | cut -d: -f2)" || :
currentTimer="$(grep "timer" "${oldConfig}" | cut -d: -f2)" || :

latestVersion="$(curl --silent "https://api.github.com/repos/AntonVanAssche/BashPass/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')"

# Detect user
if [[ "${UID}" == 0 ]]; then
   printf "You must run this as a normal user.\nCurrent user ID: %s %s\n" "${UID}" "$([[ "${UID}" -eq 0 ]] && printf "(root)")"
   exit 13
fi

printf "Updating BashPass to version: '%s'...\n" "${latestVersion}"
printf "\n"

#git clone -b -q "$(basename "$(curl -Ls -o /dev/null -w "%{url_effective}" https://github.com/AntonVanAssche/BashPass/releases/latest)")" \
   # https://github.com/AntonVanAssche/BashPass.git

# Current replacement for cloning the latest version.
git clone https://github.com/AntonVanAssche/BashPass.git
cd BashPass/
git checkout develop
cd ../

case $(grep "version" "${config}" | cut -d: -f2) in
   "1.0"| "1.1")
      cp -r "${currentDir}"/BashPass/config/bashpass.conf "${config}"

      printf "email: %s" "${currentEmail}" >> "${config}"
      sed -i "2s|.local/share/bashpass|${currentLocation}|g" "${config}"
      sed -i "3s|10|${currentTimer}|g" "${config}"
      ;;
   *)
      sed -i "1s|${currentVersion}|${latestVersion}|g" "${config}"
      ;;
esac

cp -r "${currentDir}/BashPass/bashpass" "${HOME}/.local/bin/bashpass"
rm -rf "${oldConfig}" BashPass/

