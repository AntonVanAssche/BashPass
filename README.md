<div align="center">
   <h1>BashPass</h1>
   <p>A local command-line password manager written in Bash.</p>
   <p>
      <a href="https://github.com/AntonVanAssche/BashPass/issues">Report a bug</a>
      ·
      <a href="https://github.com/AntonVanAssche/BashPass/issues">Request a feature</a>
   </p>
</div>

## About

BashPass uses GnuPG to encrypt passwords before storing them locally. No remote service is required.
The password store can optionally be managed as a Git repository.

## Requirements

- Bash 3.0 or newer
- GnuPG (`gpg` or `gpg2`)

Git is only required when using `--git` or `-G`.

A clipboard utility is only required when using `-c` or `--copy`, such as `xclip` or `wl-copy`.

## Installation

Clone the repository and run:

```console
git clone https://github.com/AntonVanAssche/BashPass.git
cd BashPass
sudo make install
```

Alternatively, download a release from the [releases
page](https://github.com/AntonVanAssche/BashPass/releases/latest).

Release archives are signed with the following signing key:
[AB592CC1A4D17E654ED55FE83FF8016D27683E3E](https://keyserver.ubuntu.com/pks/lookup?search=0x3ff8016d27683e3e&op=vindex).
To verify the signature, use `gpg --verify BashPass-X.X.tar.gz.asc`

BashPass will prompt you for the GnuPG key ID to use for encryption. The key ID is only used for
that invocation. To avoid being prompted, set `BASHPASS_KEY_ID` in your environment.

## Usage

```console
Usage:
    bashpass [OPTION] [NAME]

Commands:
    -a, --add [NAME]       Add a password.
    -c, --copy [NAME]      Copy a password to the clipboard.
    -d, --delete [NAME]    Delete a password.
    -l, --list             List all passwords.
    -s, --show [NAME]      Show a password.
    -u, --update [NAME]    Update a password.
    -G, --git COMMAND      Interact with Git. Wrapper for 'git -C ${BASHPASS_PASSWD_STORE} COMMAND'.

Options:
    -h, --help             Show this help message.
    -v, --version          Show the version number.

Arguments:
    NAME                   Password name. If omitted, you will be prompted.
```

## Configuration

BashPass is configured through environment variables. Settings that are not explicitly configured
use their default values.

| Variable | Default | Description |
| - | - | - |
| `BASHPASS_CLIPBOARD_CLEAR_CMD` | `wl-copy --clear` | Command used to clear the clipboard. |
| `BASHPASS_CLIPBOARD_COPY_CMD` | `wl-copy` | Command used to copy a password to the clipboard. |
| `BASHPASS_CLIPBOARD_TIMER` | `10` | Number of seconds a copied password remains in the clipboard. |
| `BASHPASS_KEY_ID` | Prompt | GnuPG key ID used to encrypt passwords. |
| `BASHPASS_PASSWD_LENGTH` | `14` | Default length of generated passwords. |
| `BASHPASS_PASSWD_STORE` | `~/.local/share/bashpass` | Location of the password store. |

`BASHPASS_KEY_ID` may contain the last 8 characters or the complete 40-character GnuPG fingerprint.
If it is unset, BashPass prompts for a key ID when it starts.

The default clipboard commands use `wl-copy` and therefore require a Wayland environment. Set
`BASHPASS_CLIPBOARD_COPY_CMD` and `BASHPASS_CLIPBOARD_CLEAR_CMD` to commands appropriate for your
clipboard manager.

## Git Integration

BashPass does not manage Git repositories itself. Use `--git` or `-G` to run Git commands against
the password store:

```txt
bashpass -G COMMAND [ARGUMENT ...]
```

This is equivalent to running:

```txt
git -C "${BASHPASS_PASSWD_STORE}" COMMAND [ARGUMENT ...]
```

This allows the password store to be managed like any other Git repository, including using custom
commit messages, branches, remotes, signing, and other Git features.

## Bash completion

BashPass includes optional Bash completion for commands and stored password
names. Source `scripts/bashpass-completion.sh` from your `.bashrc`:

```bash
. /path/to/bashpass-completion.sh
```

## Contributing

Bug reports, feature requests, and pull requests are welcome.

See [`CONTRIBUTING.md`](./CONTRIBUTING.md) for contribution guidelines.

## License

BashPass is distributed under the MIT License. See [`LICENSE.md`](./LICENSE.md) for details.
