#!/usr/bin/env bash

set -o errexit  # Abort on nonzero exit code.
set -o nounset  # Abort on unbound variable.
set -o pipefail # Don't hide errors within pipes.

# GPG key ID to use for signing all BashPass releases.
readonly KEY_ID="27683E3E"

# Detect both 'gpg' and 'gpg2', when both are installed
# 'gpg2' will be used, since it's more secure.
command -v gpg &> /dev/null && gpg_command="gpg"
command -v gpg2 &> /dev/null && gpg_command="gpg2"

# Check if the GnuPG key is present on the system.
if ! "${gpg_command}" --list-keys "${KEY_ID}" &> /dev/null; then
    printf 'GnuPG key %s not found on the system. Aborting.' "'${KEY_ID}'" >&2
    exit 1
fi

# Check whether the release files are present in the current directory.
# Because there are two different file extensions ('tar.gz' and '.zip'),
# we need to use the 'compgen' command to generate a list of all files
# with the given extensions. Normally, we would use '-f' to check if a file exists,
# but this doesn't work with globs.
# See: https://stackoverflow.com/a/34195247
if ! compgen -G ./*.tar.gz &> /dev/null && ! compgen -G ./*.zip &> /dev/null; then
    printf 'No release files found in the current directory. Aborting.' >&2
    exit 1
fi

# Sign all release files.
for file in ./*.{tar.gz,zip}; do
    # Sign the file
    "${gpg_command}" --detach-sign --armor --local-user "${KEY_ID}" "${file}"

    # Verify the signature
    "${gpg_command}" --verify "${file}.asc" "${file}"
done
