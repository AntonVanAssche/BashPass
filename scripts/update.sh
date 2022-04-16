#!/bin/bash

# Abort the script when an error occures.
set -e

currentDir="$(pwd)"

configLocation="$HOME/.config/bashpass"
config="${configLocation}/bashpass.conf"
oldConfig="${config}.old"

latestVersion="$(curl --silent "https://api.github.com/repos/AntonVanAssche/BashPass/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')"

# Simple function to get the setting '${1}' from the old config file.
# This basically replaces the '$(grep "setting" "$oldConfig" | cut -d: -f2)'.
# It's also pure bash, which means that no sub shells are used.
GetOldSetting() {
   while read;
   do
      if [[ "$REPLY" =~ ^${1} ]]; then
         echo "${REPLY#*:}"
         break
      fi
   done < "${oldConfig}"
}

# Simple function to get the setting '${1}' from the config file.
# This basically replaces the '$(grep "setting" "$config" | cut -d" " -f2)'.
# It's also pure bash, which means that no sub shells are used.
GetNewSetting() {
   while read;
   do
      if [[ "$REPLY" =~ ^${1} ]]; then
         echo "${REPLY#*: }"
         break
      fi
   done < "${config}"
}

# Simple function to replace the default settings inside the new config file with your personal settings form the old config file.
# This basically replaces the 'sed -i "2s|setting|${newSetting}|g" "${config}"'.
# It's also pure bash, which means that no sub shells are used.
ReplaceOldSettings() {
   while read;
   do
      case ${REPLY} in
         "location: "*)
            setting+=("${REPLY%%:*}: ${currentLocation}")
            ;;
         "timer: "*)
            setting+=("${REPLY%%:*}: ${currentTimer}")
            ;;
         *)
            setting+=("${REPLY}")
            ;;
      esac
   done < "${config}"

   printf '%s\n' "${setting[@]}" > "${config}"
   printf "email: %s" "${currentEmail}" >> "${config}"
}

# Simple function to replace the version number inside the config file.
# This basically replaces the 'sed -i "1s|${currentVersion}|${latestVersion}|g" "${config}"'.
# It's also pure bash, which means that no sub shells are used.
ReplaceVersion() {
   while read;
   do
      case ${REPLY} in
         "version: "*)
            setting+=("${REPLY%%:*}: ${latestVersion}")
            ;;
         *)
            setting+=("${REPLY}")
            ;;
      esac
   done < "${config}"

   printf '%s\n' "${setting[@]}" > "${config}"
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

Main() {
   # Detect user
   if [[ "${UID}" == 0 ]]; then
      printf "You must run this as a normal user.\nCurrent user ID: %s %s\n" "${UID}" "$([[ "${UID}" -eq 0 ]] && printf "(root)")"
      exit 13
   fi

   printf "Updating BashPass to version: '%s'...\n" "${latestVersion}"
   printf "\n"

   case $(GetOldSetting 'version') in
      "1.0"| "1.1")
         mv "${config}" "${oldConfig}"
         currentEmail="$(GetOldSetting 'email')" || :
         currentLocation="$(GetOldSetting 'location')" || :
         currentTimer="$(GetOldSetting 'timer')" || :

         cp -r "${currentDir}"/BashPass/config/bashpass.conf "${config}"

         ReplaceOldSettings
         ;;
      *)
         ReplaceVersion
         ;;
   esac

   cp -r "${currentDir}/BashPass/bashpass" "${HOME}/.local/bin/bashpass"
   rm -rf "${oldConfig}" BashPass/
}

Main "$@"
