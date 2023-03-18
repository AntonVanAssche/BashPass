Welcome to the BashPass user guide!
This guide provides an overview of all the features of BashPass, from creating a password to synchronizing your passwords with a remote git repository.

## Help option

If you are not sure about the correct option to use, simply run bashpass with the `--help` or `-h` option. This will display all the features of BashPass.

**Note**: the `[name]` is optional.

```
bashpass [option] [name]                            - Basic command structure.

Options:
--help      or -h                                   - Show this help message.
--version   or -v                                   - Show the version number
--list      or -l                                   - List all password.
--add       or -a                            [name] - Add a password.
--update    or -u                            [name] - Update a password.
--delete    or -d                            [name] - Delete a password.
--show      or -s                            [name] - Show a password.
--copy      or -c                            [name] - Copy a password to the clipboard.
--sync      or -S    [synchronize command]          - Synchronize password(s) with a git repository.

Synchronize command:
    upload           - Upload local password(s) to a remote repository.
    download         - Download password(s) from a remote repository.
```

Examples:

-  `bashpass --add gmail`
-  `bashpass --delete gmail`
-  `bashpass --show gmail`
-  `bashpass --list`

## Adding a password

To add a password, use the `--add` or `-a` option.

```bash
$ bashpass --add [password]
```

BashPass will prompt you to choose whether you want to generate a password or not.
If you want to enter the password manually, type 'n' and then press 'enter'.
Otherwise, just press 'enter'.

```
Do you want to generate a password [Y/n]: y
```

If you choose to generate the password, another prompt will appear asking you to enter the desired password length.
The default length is 14, but this can be changed in the configuration file.
Press 'enter' to use the default length, or enter a number and press 'enter' to specify a different length.

```
Give the length of the password (Default: 14):
```

## Updating a password

This feature allows you to update an existing password. To use this option, run BashPass with the `--update` or `-u` flag.

```bash
$ bashpass --update [password]
```

This will ask the same questions as the `--add` feature.

## Deleting a password

To delete a password from your system, run BashPass with the `--delete` or `-d` option.

**Note**: Be careful with this option, once you delete a password there is no way to recover it.

```bash
$ bashpass -d [password]
```

## Show a password

This feature will display the password in your terminal.

**NOTE**: this will return the password in plain text.

```bash
$ bashpass --show [password]
```

## Copy a password

This feature is more secure than the `--show` option because the clipboard will be cleared after a certain amount of time (default is 10 seconds), and the password will never be shown in the terminal.
You can use this feature by using the `--copy` or `-c` flag.

```bash
$ bashpass --copy [password]
```

## Synchronize a password

BashPass provides a feature to synchronize your local passwords with a remote git repository.
The synchronization functionality requires git to be installed on your system.

It's recommended to set up an SSH key with the remote git server, whether it's a self-hosted one or a third-party provider like GitHub or GitLab.
BashPass should work with both options.

By default, BashPass stores passwords in `~/.local/share/bashpass/`.
You can use this location as a git repository or set up a different location as a git repository.
It's up to you to choose which option suits you best.

**Note**: You'll have to import your GPG key on every device you want to use the synchronization functionality.
You can follow this guide https://www.debuntu.org/how-to-importexport-gpg-key-pair/ for importing and exporting your GPG keys.

### Upload

The `upload` option will upload all local changes to the remote git repository.

```bash
$ bashpass --sync upload
```

### Download

The `download` option will download all changes from the remote git repository to the user's local machine.

```bash
$ bashpass --sync download
```
