This page provides instructions on how to use BashPass.

# Basic Command Structure

```
Usage:
    bashpass [OPTION] [NAME]

Commands:
    -a, --add [NAME]       Add a password.
    -c, --copy [NAME]      Copy a password to the clipboard.
    -d, --delete [NAME]    Delete a password.
    -l, --list             List all passwords.
    -s, --show [NAME]      Show a password.
    -u, --update [NAME]    Update a password.
    -S, --sync COMMAND     Synchronize with a Git repository.

Options:
    -h, --help             Show this help message.
    -v, --version          Show the version number.

Sync commands:
    push                   Push local passwords to a remote repository.
    pull                   Pull passwords from a remote repository.

Arguments:
    NAME                   Password name. If omitted, you will be prompted.
```

# Options

##  `--help` | `-h`

Show a brief help message.

##  `--version` | `-v`

Display the version number of your BashPass installation.

##  `--add` | `-a`

Add a new password to the system. The password can be either self-chosen or auto-generated.
If no `NAME` is specified, BashPass will ask for it.

```console
$ bashpass --add gmail
```

##  `--copy` | `-c`

Copy the password of the specified `NAME` to the clipboard.
The clipboard will be cleared after a certain amount of time, specified in the configuration file.

```console
$ bashpass --copy gmail
```

##  `--delete` | `-d`

> :warning: Be careful, BashPass will not ask for confirmation!

Delete the password of the specified `NAME` from the system.

```console
$ bashpass --delete gmail
```

##  `--show` | `-s`

> :warning: BashPass wil print the password in clear text to the terminal.

Print the password of the specified NAME to stdout.

```console
$ bashpass --show gmail
```

##  `--update` | `-u`

> :warning: BashPass will overwrite the previous password!

Update the password of the specified `NAME`.
The password can be either self-chosen or auto-generated.

```console
$ bashpass --update gmail
```

##  `--list` | `-l`

List all the names of the passwords stored in the password store.

```console
$ bashpass --list
```

##  `--git` | `-G`

Interact with git with the password store as working directory.
This essentially is a wrapper around `git -C ${BASHPASS_PASSWD_STORE} COMMAND`.

```console
$ bashpass --git init
$ bashpass --git add foo.gpg
```
