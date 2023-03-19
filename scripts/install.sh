#!/usr/bin/env bash

# Abort the script when an error occures.
set -e

current_dir="$(pwd)"
latest_version="$(curl --silent "https://api.github.com/repos/AntonVanAssche/BashPass/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')"

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

    printf 'Installing BashPass version: '\''%s'\''...' "${latest_version}"
    printf '\n'

    git clone https://www.github.com/AntonVanAssche/BashPass.git --branch "$(get_latest_version)"

    mkdir -p "${HOME}/.config/bashpass"
    mkdir -p "${HOME}/.local/share/bashpass"
    mkdir -p "${HOME}/.local/bin"

    cp -r "${current_dir}/BashPass/config/bashpass.conf" "${HOME}/.config/bashpass/bashpass.conf"
    cp -r "${current_dir}/BashPass/bashpass" "${HOME}/.local/bin/bashpass"

    printf 'Installing man pages'
    printf '\n'

    [[ ! -d "${HOME}/.local/share/man/man1/" ]] && mkdir -p "${HOME}/.local/share/man/man1/"
    cp -r "${current_dir}"/BashPass/docs/bashpass.{1,conf.1}.gz "${HOME}/.local/share/man/man1/"

    printf 'Make sure to add '\''\${HOME}/.local/bin/'\'' to your \$PATH.'
    printf '\n'

    rm -rf BashPass/
}

main "${@}"
