#!/usr/bin/env bash

# Abort the script when an error occures.
set -e

currentDir="$(pwd)"
latestVersion="$(curl --silent "https://api.github.com/repos/AntonVanAssche/BashPass/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')"

# Get latest release from GitHub api
GetLatestRelease() {
  curl --silent "https://api.github.com/repos/AntonVanAssche/BashPass/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/'
}

Main() {
   # Detect user
   if [[ "${UID}" == 0 ]]; then
      printf 'You must run this as a normal user.\nCurrent user ID: %s %s\n' "${UID}" "$([[ "${UID}" -eq 0 ]] && printf "(root)")"
      exit 13
   fi

   printf 'Installing BashPass version: '\''%s'\''...' "${latestVersion}"
   printf '\n'

   git clone https://www.github.com/AntonVanAssche/BashPass.git --branch "$(GetLatestRelease)"

   mkdir -p "${HOME}/.config/bashpass"
   mkdir -p "${HOME}/.local/share/bashpass"
   mkdir -p "${HOME}/.local/bin"

   cp -r "${currentDir}/BashPass/config/bashpass.conf" "${HOME}/.config/bashpass/bashpass.conf"
   cp -r "${currentDir}/BashPass/bashpass" "${HOME}/.local/bin/bashpass"

   printf 'Installing man pages'
   printf '\n'

   [[ ! -d "${HOME}/.local/share/man/man1/" ]] && mkdir -p "${HOME}/.local/share/man/man1/"
   cp -r "${currentDir}"/BashPass/docs/bashpass.{1,conf.1}.gz "${HOME}/.local/share/man/man1/"

   printf 'Make sure to add '\''\${HOME}/.local/bin/'\'' to your \$PATH.'
   printf '\n'

   rm -rf BashPass/
}

Main "${@}"
