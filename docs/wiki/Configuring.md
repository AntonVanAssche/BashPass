This page provides instructions on how to configure BashPass using environment
variables.

# Configuration

BashPass is configured using environment variables. Only `BASHPASS_KEY_ID` is
required.

If `BASHPASS_KEY_ID` is not set, BashPass will prompt you for a GnuPG key ID
when it starts. The key ID is only used for that invocation and will not be
saved.

To make the key ID persistent, set `BASHPASS_KEY_ID` in your shell environment:

```sh
export BASHPASS_KEY_ID=12345678
```

This can be useful if you normally use a single GnuPG key.

If you work with multiple GnuPG keys, leaving `BASHPASS_KEY_ID` unset allows
BashPass to prompt for the appropriate key each time.

The key ID should be the last 8 characters of the GnuPG key fingerprint, or the
complete 40 characters long fingerprint.

# Optional Settings

BashPass provides a few optional environment variables for changing its default
behaviour.

## Clipboard Clear Command

`BASHPASS_CLIPBOARD_CLEAR_CMD` controls the command used to clear the clipboard.

By default, this is set to **wl-copy --clear**.

> [!NOTE]
> The default configuration only works if `wl-copy` is installed on your system
> and you are using Wayland.

```sh
export BASHPASS_CLIPBOARD_CLEAR_CMD="xclip -selection clipboard < /dev/null"
```

## Clipboard Copy Command

`BAHSPASS_COPY_CMD` controls the command used to copy the password to the
clipboard.

By default, this is set to **wl-copy**.

> [!NOTE]
> The default configuration only works if `wl-copy` is installed on your system
> and you are using Wayland.

```sh
export BASHPASS_CLIPBOARD_COPY_CMD="xclip -selection clipboard"
```

## Password Length

`BASHPASS_PASSWD_LENGTH` controls the default length of generated passwords.

By default, this is set to **14** characters.

For example:

```sh
export BASHPASS_PASSWD_LENGTH=16
```

This value can still be overridden when generating a password.

## Password Store Location

`BASHPASS_PASSWD_STORE` controls where BashPass stores encrypted password
files.

By default, the password store is located at: **~/.local/share/bashpass**.

For example:

```sh
export BASHPASS_PASSWD_STORE="${HOME}/.passwords"
```

The value must be an absolute path and must be writable by the user executing
BashPass.

If the directory does not exist, the script will attempt to create it. In case
this operation fails, the script will fail gracefully.

## Clipboard Timer

`BASHPASS_TIMER` controls how long BashPass keeps a password in the clipboard
when using the `-c` or `--copy` option.

By default, this is set to **10** seconds.

For example:

```sh
export BASHPASS_TIMER=5
```

This will clear the clipboard after 5 seconds.

# Environment Variables

| Variable | Default | Description |
| - | - | - |
| `BASHPASS_CLIPBOARD_CLEAR_CMD` | `wl-copy --clear` | Command to clear the clipboard |
| `BASHPASS_CLIPBOARD_COPY_CMD` | `wl-copy` | Command to copy the password to the clipboard |
| `BASHPASS_KEY_ID` | Prompt | GnuPG key ID used to encrypt passwords |
| `BASHPASS_PASSWD_LENGTH` | `14` | Default generated password length |
| `BASHPASS_PASSWD_STORE` | `~/.local/share/bashpass` | Password store location |
| `BASHPASS_TIMER` | `10` | Clipboard timeout in seconds |
