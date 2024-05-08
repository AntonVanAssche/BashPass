This page provides instructions on how to use BashPass.

# 1. Basic Command Structure

```
Usage: bashpass [OPTION] [NAME | SYNC_COMMAND]

Options:
    --help    | -h                      Show this help message.
    --version | -v                      Show the version number.
    --add     | -a [NAME]               Add a password.
    --copy    | -c [NAME]               Copy a password to the clipboard.
    --delete  | -d [NAME]               Delete a password.
    --show    | -s [NAME]               Show a password.
    --update  | -u [NAME]               Update a password.
    --list    | -l                      List all passwords.
    --sync    | -S [SYNC_COMMAND]       Synchronize password(s) with a git repository.

Synchronize commands:
    upload                              Upload local password(s) to a remote repository.
    download                            Download password(s) from a remote repository.

Note:
    [NAME] is an optional argument. If not provided, the script will prompt you to enter it.
```

# 2. Options

## 2.1 `--help` | `-h`

Show a brief help message.

## 2.2 `--version` | `-v`

Display the version number of your BashPass installation.

## 2.3 `--add` | `-a`

Add a new password to the system. The password can be either self-chosen or auto-generated.
If no `NAME` is specified, BashPass will ask for it.

```console
$ bashpass --add gmail
```

## 2.2 `--copy` | `-c`

Copy the password of the specified `NAME` to the clipboard.
The clipboard will be cleared after a certain amount of time, specified in the configuration file.

```console
$ bashpass --copy gmail
```

## 2.3 `--delete` | `-d`

> :warning: Be careful, BashPass will not ask for confirmation!

Delete the password of the specified `NAME` from the system.

```console
$ bashpass --delete gmail
```

## 2.4 `--show` | `-s`

> :warning: BashPass wil print the password in clear text to the terminal.

Print the password of the specified NAME to stdout.

```console
$ bashpass --show gmail
```

## 2.5 `--update` | `-u`

> :warning: BashPass will overwrite the previous password!

Update the password of the specified `NAME`.
The password can be either self-chosen or auto-generated.

```console
$ bashpass --update gmail
```

## 2.6 `--list` | `-l`

List all the names of the passwords stored in the password store.

```console
$ bashpass --list
```

## 2.7 `--sync` | `-S`

> :warning: The password store must be initialized with a remote Git repository before using this command.

Sync the password store with a remote Git repository.
The `SYNC_COMMAND` can be either `upload` or `download`.

```console
$ bashpass --sync upload
$ bashpass --sync download
```
