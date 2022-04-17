#!/bin/bash

# Abort the script when an error occures.
set -e

configLocation="$HOME/.config/bashpass"
config="${configLocation}/bashpass.conf"

printf 'This action will remove all passwords that are stored in '\''%s'\''.' "${HOME}/.local/share/bashpass"
printf '\n'
printf 'Are you sure you want to proceed [y/N]: '
read -r answer

case "${answer}" in
   [yY][eE][sS]|[yY])
      printf 'Uninstalling BashPass version: '\''%s'\''...\n' "$(grep "version" "${config}" | cut -d: -f2)"
      rm -rf "${HOME}/.config/bashpass" "${HOME}/.local/share/bashpass" "${HOME}/.local/bin/bashpass"
      printf '\nWe hate to see you go.\n'
      ;;
   *)
      printf 'Aborting.\n'
      ;;
esac
