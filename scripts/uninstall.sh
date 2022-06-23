#!/usr/bin/env bash

# Abort the script when an error occures.
set -e

configLocation="$HOME/.config/bashpass"
config="${configLocation}/bashpass.conf"

# Simple function to get the setting 'version' from the config file.
# This basically replaces the '$(grep "version" "$config" | cut -d" " -f2)'.
# It's also pure bash, which means that no sub shells are used.
GetVersion() {
   while read -r;
   do
      if [[ "${REPLY}" =~ ^version ]]; then
         printf '%s' "${REPLY#*: }"
         break
      fi
   done < "${config}"
}

Main() {
   printf 'This action will remove all passwords that are stored in '\''%s'\''.' "${HOME}/.local/share/bashpass"
   printf '\n'
   printf 'Are you sure you want to proceed [y/N]: '
   read -r answer

   case "${answer}" in
      [yY][eE][sS]|[yY])
         printf 'Uninstalling BashPass version: '\''%s'\''...\n' "$(GetVersion)"
         rm -rf "${HOME}/.config/bashpass" "${HOME}/.local/share/bashpass" "${HOME}/.local/bin/bashpass" "${HOME}"/.local/share/man/man1/bashpass.{1,conf.1}.gz
         printf '\nWe hate to see you go.\n'
         ;;
      *)
         printf 'Aborting.\n'
         ;;
   esac
}

Main "${@}"
