#!/usr/bin/env bash

# Abort the script when an error occures.
set -e

current_dir="$(pwd)"

config_location="$HOME/.config/bashpass"
config="${config_location}/bashpass.conf"
old_config="${config}.old"

latestVersion="$(curl --silent "https://api.github.com/repos/AntonVanAssche/BashPass/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')"

cp "${config}" "${old_config}"

# Simple function to get the setting '${1}' from the old config file.
# This basically replaces the '$(grep "setting" "$old_config" | cut -d: -f2)'.
# It's also pure bash, which means that no sub shells are used.
get_old_setting() {
    while read -r;
    do
        if [[ "${REPLY}" =~ ^${1} ]]; then
            printf '%s' "${REPLY#*:}"
            break
        fi
    done < "${old_config}"
}

# Simple function to get the setting '${1}' from the config file.
# This basically replaces the '$(grep "setting" "$config" | cut -d" " -f2)'.
# It's also pure bash, which means that no sub shells are used.
get_new_setting() {
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
replace_old_setting() {
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
get_latest_version() {
  curl --silent "https://api.github.com/repos/AntonVanAssche/BashPass/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/'
}

main() {
    # Detect user
    if [[ "${UID}" == 0 ]]; then
        printf 'You must run this as a normal user.\nCurrent user ID: %s %s\n' "${UID}" "$([[ "${UID}" -eq 0 ]] && printf "(root)")"
        exit 13
    fi

    printf 'Updating BashPass to version: '\''%s'\''...\n' "${latestVersion}"
    printf '\n'

    git clone https://www.github.com/AntonVanAssche/BashPass.git --branch "$(get_latest_version)"

    case $(get_old_setting 'version') in
        "1.0"| "1.1")
            # This fixes a bug where the e-mail address was not copied over to the new config format.
            printf '\n' >> "${old_config}"

            currentEmail="$(get_old_setting 'email')" || :
            currentLocation="$(get_old_setting 'location')" || :
            currentTimer="$(get_old_setting 'timer')" || :

            cp -r "${current_dir}"/BashPass/config/bashpass.conf "${config}"

            replace_old_setting
            ;;
        *)
            ReplaceVersion
            ;;
    esac

    printf 'Installing man pages'
    printf '\n'

    [[ ! -d "${HOME}/.local/share/man/man1/" ]] && mkdir -p "${HOME}/.local/share/man/man1/"
    cp -r "${current_dir}"/BashPass/docs/bashpass.{1,conf.1}.gz "${HOME}/.local/share/man/man1/"

    cp -r "${current_dir}/BashPass/bashpass" "${HOME}/.local/bin/bashpass"
    rm -rf "${old_config}" BashPass/
}

main "${@}"
