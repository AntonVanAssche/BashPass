#!/bin/bash

# Abort the script when an error occures.
set -e

currentDir="$(pwd)"
latestVersion="$(curl --silent "https://api.github.com/repos/AntonVanAssche/BashPass/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')"

# Detect user
if [[ "${UID}" == 0 ]]; then
   printf 'You must run this as a normal user.\nCurrent user ID: %s %s\n' "${UID}" "$([[ "${UID}" -eq 0 ]] && printf "(root)")"
   exit 13
fi

printf 'Installing BashPass version: '\''%s'\''...' "${latestVersion}"
printf '\n'

#git clone -b -q "$(basename "$(curl -Ls -o /dev/null -w "%{url_effective}" https://github.com/AntonVanAssche/BashPass/releases/latest)")" \
   # https://github.com/AntonVanAssche/BashPass.git

# Current replacement for cloning the latest version.
git clone https://github.com/AntonVanAssche/BashPass.git
cd BashPass/
git checkout develop
cd ../

mkdir -p "${HOME}/.config/bashpass"
mkdir -p "${HOME}/.local/share/bashpass"

cp -r "${currentDir}/BashPass/config/bashpass.conf" "${HOME}/.config/bashpass/bashpass.conf"
cp -r "${currentDir}/BashPass/bashpass" "${HOME}/.local/bin/bashpass"

printf 'Make sure to add '\''\${HOME}/.local/bin/'\'' to your \$PATH.'
printf '\n'

rm -rf BashPass/
