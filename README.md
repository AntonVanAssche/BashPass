# BashPass

BashPass is a password manager written in Bash. It uses GPG to encrypt/decrypt the files where the passwords are stored (default: `~/.local/share/bashpass/`). This means the password are 100% stored locally, so you don't have to trust a third party to store your passwords.

## Table of contents

-  [Dependencies](#dependencies)
-  [Usage](#usage)
-  [Installing BashPass](#installing-bashpass)
-  [Updating BashPass](#updating-bashpass)
-  [Uninstalling BashPass](#uninstalling-bashpass)
-  [Synchronize passwords between devices](#synchronize-passwords-between-devices)
-  [Configuring BashPass](#configuring-bashpass)
   -  [Configuring the location where passwords are stored](#configuring-the-location-where-passwords-are-stored)
   -  [Configuring the email address](#configuring-the-e-mail-address)
   -  [Configuring the clipboard timer](#configuring-the-clipboard-timer)
   -  [Configuring the default password length](#configuring-the-default-password-length)
-  [Feedback](#feedback)

## Dependencies

-  gpg (Used to encrypt the password files)
-  xclip (Used to copy the password to the clipboard)
-  scp (Used to copy the password to another device on your local network)
-  ssh (Used to import your GPG keys on another device)

## Usage

Note: the `[name]` is optional.

```
bashpass [option] [name]                      - Basic command structure.

Options:
--help       or -h                            - Show this help message.
--version    or -v                            - Show the version number
--add        or -a                     [name] - Add a password.
--update     or -u                     [name] - Update a password.
--delete     or -d                     [name] - Delete a password.
--show       or -s                     [name] - Show a password.
--copy       or -c                     [name] - Copy a password to the clipboard.
--list       or -l                            - List all password.
--sync       or -S                     [name] - Synchronize a password with a other device on your local network.
```

Examples:

-  `bashpass --add gmail`
-  `bashpass --delete gmail`
-  `bashpass --show gmail`
-  `bashpass --list`

## Installing BashPass

First you'll have to generate a GPG key. Run the following command to do so, and your key will be generated (you can use the defaults for most questions).

```bash
$ gpg --full-generate-key
```

Now it's time to install BashPass. Just run the `setup.sh` script and you'll be good to go.

```bash
$ ./setup.sh --install
```

After installation, you'll have to add `.local/bin` to your PATH to use BashPass. Add the following line in your `.bashrc` file.

```bash
export PATH="$HOME/.local/bin:$PATH"
```

When you start BashPass for the first time you'll be prompted with the question to enter an e-mail address. You must enter the same e-mail address that you've used to generate the GPG key.

```
Enter the email address you created the gpg key with:
```

## Updating BashPass

To update BashPass to the latest version, just run the `setup.sh` script and you'll be good to go.

```bash
$ ./setup.sh --update
```

## Uninstalling BashPass

To uninstall BashPass, just run the `setup.sh` script.

```bash
$ ./setup.sh --uninstall
```

## Synchronize passwords between devices

The `sync` option of BashPass allows you to copy a password from your device to another device on your local network using `ssh` and `scp`. This option can used like shown below.

**Note**: you'll have to import your private key to view the password and the public key in case you want to add a new password **(BashPass can do this for you)**.

```bash
$ bashpass --sync password
```

or:

```bash
$ bashpass -S password
```

## Configuring BashPass

BashPass has a configuration file located at `~/.config/bashpass/bashpass.conf`. Here you can change a few basic things like the email address, the default location where your passwords are stored, and a few other settings. Below you can find the default configuration file.

```
version: 2.0
location: .local/share/bashpass
timer: 10
length: 14
```

### Configuring the location where passwords are stored

By default BashPass stores the passwords the following directory `~/.local/share/bashpass/`. In case you want to change the location you'll have to change the following line in the config file.

```
location: .local/share/bashpass
```

**Example**: if you want to store the passwords in `.bashpass/passwords/`. You'll have to update the line to:

**Note**: The new location has to be located inside **your home** (`~`) directory.

```
location: .bashpass/passwords/
```

### Configuring the e-mail address

Changing the e-mail address isn't recommended but in case you need to do this here you go. To update the e-mail address you'll have to update the following line in the config file.

```
email: email@gmail.com
```

**Example**: if you want to update the e-mail address to `newemail@gmail.com`. You'll have to update the line to:

**Note**: when you update the e-mail address you'll have to generate a new GPG key. You will also be unable to read your passwords you have stored with the old e-mail address.

```
email: newemail@gmail.com
```

### Configuring the clipboard timer

By default BashPass has a timer of `10` seconds. This value is the amount of seconds you have to paste your password you copied using the `copy` option. The duration of the timer can be changed in the config file. To change this edit the following line.

```
timer: 10
```

**Example**: if you want to update the timer to `15` seconds. You'll have to update the line to:

```
timer: 15
```

### Configuring the default password length

By default all random generated passwords will be 14 characters long when no specific length is given when prompted (since version: `2.0`). You can however change this to as many characters you want.
This can be done by editing the following line in the config file.

```
length: 14
```

**Example**: if you want to update the default password length to `25` characters long. You'll have to update the line to:

```
length: 25
```

## Feedback

This project isn't perfect, therefore suggestions/improvements are always [welcome](https://github.com/TuX-sudo/BashPass/issues)!
