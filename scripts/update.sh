#!/usr/bin/env bash

# Abort the script when an error occures.
set -e

currentDir="$(pwd)"

configLocation="$HOME/.config/bashpass"
config="${configLocation}/bashpass.conf"
oldConfig="${config}.old"

latestVersion="$(curl --silent "https://api.github.com/repos/AntonVanAssche/BashPass/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')"

cp "${config}" "${oldConfig}"

# Simple function to get the setting '${1}' from the old config file.
# This basically replaces the '$(grep "setting" "$oldConfig" | cut -d: -f2)'.
# It's also pure bash, which means that no sub shells are used.
GetOldSetting() {
    while read -r;
    do
        if [[ "${REPLY}" =~ ^${1} ]]; then
            printf '%s' "${REPLY#*:}"
            break
        fi
    done < "${oldConfig}"
}

# Simple function to get the setting '${1}' from the config file.
# This basically replaces the '$(grep "setting" "$config" | cut -d" " -f2)'.
# It's also pure bash, which means that no sub shells are used.
GetNewSetting() {
    while read -r;
    do
        if [[ "${REPLY}" =~ ^${1} ]]; then
            printf '%s' "${REPLY#*: }"
            break
        fi
    done < "${config}"
}

# Simple function to replace the default settings inside the new config file with your personal settings form the old config file.
# This basically replaces the 'sed -i "2s|setting|${newSetting}|g" "${config}"'.
# It's also pure bash, which means that no sub shells are used.
ReplaceOldSettings() {
    while read -r;
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
    printf 'email: %s\n' "${currentEmail}" >> "${config}"
}

# Simple function to replace the version number inside the config file.
# This basically replaces the 'sed -i "1s|${currentVersion}|${latestVersion}|g" "${config}"'.
# It's also pure bash, which means that no sub shells are used.
ReplaceVersion() {
    while read -r;
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

    printf 'Updating BashPass to version: '\''%s'\''...\n' "${latestVersion}"
    printf '\n'

    git clone https://www.github.com/AntonVanAssche/BashPass.git --branch "$(GetLatestRelease)"

    case $(GetOldSetting 'version') in
        "1.0"| "1.1")
            # This fixes a bug where the e-mail address was not copied over to the new config format.
            printf '\n' >> "${oldConfig}"

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

    printf 'Installing man pages'
    printf '\n'

    [[ ! -d "${HOME}/.local/share/man/man1/" ]] && mkdir -p "${HOME}/.local/share/man/man1/"
    cp -r "${currentDir}"/BashPass/docs/bashpass.{1,conf.1}.gz "${HOME}/.local/share/man/man1/"

    cp -r "${currentDir}/BashPass/bashpass" "${HOME}/.local/bin/bashpass"
    rm -rf "${oldConfig}" BashPass/
}

Main "${@}"
