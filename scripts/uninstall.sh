#!/bin/bash

# Abort the script when an error occures.
set -e

configLocation="$HOME/.config/bashpass"
config="${configLocation}/bashpass.conf"

printf "Uninstalling BashPass version: '%s'..." "$(grep "version" "${config}" | cut -d: -f2)"
printf "\n"

rm -rf "${HOME}/.config/bashpass" "${HOME}/.local/share/bashpass" "${HOME}/.local/bin/bashpass"

printf "\n"
printf "We hate to see you go."

