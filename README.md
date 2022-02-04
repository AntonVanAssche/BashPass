# BashPass
BashPass is a simple password manager written in Bash. It uses GPG to encrypt/decrypt the files where the passwords are stored (default: `~/.local/share/bashpass/`). This means the password are 100% stored locally, so you don't have to trust a third party to store your passwords.

## Table of contents

- [Dependencies](#dependencies)
- [Usage](#usage)
- [Installing BashPass](#installing-bashpass)
- [Updating BashPass](#updating-bashpass)
- [Updating the config](#updating-the-config)
    - [Updating the location where passwords are stored](#updating-the-location-where-passwords-are-stored)
    - [Updating the email address](#updating-the-e-mail-address)
- [Feedback](#feedback)

## Dependencies
- gpg

## Usage
Note: the `[name]` is optional.

```
bashpass [--add|--update|--delete|--show|--copy|--list] [name] - Basic commands

--help                                   - Show this help message.
--version                                - Show the version number
--add                             [name] - Add a password.
--update                          [name] - Update a password.
--delete                          [name] - Delete a password.
--show                            [name] - Show a password.
--copy                            [name] - Copy a password to the clipboard.
--list                                   - List all password.
```

Examples: 
- `bashpass --add gmail`
- `bashpass --delete gmail`
- `bashpass --show gmail`
- `bashpass --list`

## Installing BashPass
First you'll have to generate a GPG key. Run the following command to do so, and your key will be generated (you can use the defaults for most questions).

```bash
$ gpg --full-generate-key
```

Now it's time to install BashPass. Just run the `install.sh` script and you'll be good to go.

```bash
$ ./install.sh
```

After installation, you'll have to add `.local/bin` to your PATH to use BashPass. Add the following line in your `.bashrc` file.

```bash
export PATH="/home/anton/.local/bin:$PATH"
```

When you start BashPass for the first time you'll be prompted with the question to enter an e-mail address. You must enter the same e-mail address that you've used to generate the GPG key.

```
Enter the email address you created the gpg key with:
```

## Updating BashPass
To update BashPass to the latest version, just run the install.sh script and you'll be good to go.

```bash
$ ./install.sh
```

## Updating the config
### Updating the location where passwords are stored
By default BashPass stores the passwords the following directory `~/.local/share/bashpass/`. In case you want to change the location you'll have to change the following line in the config file located at `~/.config/bashpass/bashpass.conf`.

```
location:.local/share/bashpass
```

**Example**: if you want to store the passwords in `.bashpass/passwords/`. You'll have to update the line to:

**Note**: The new location has to be located inside **your home** (`~`) directory.

```
location:.bashpass/passwords/
```

### Updating the e-mail address
Changing the e-mail address isn't recommended but in case you need to do this here you go. To update the e-mail address you'll have to update the following line in the config file located at `~/.config/bashpass/bashpass.conf`.

```
email:email@gmail.com
```

**Example**: if you want to update the e-mail address to `newemail@gmail.com`. You'll have to update the line to:

**Note**: when you update the e-mail address you'll have to generate a new GPG key. You will also be unable to read your passwords you have stored with the old e-mail address.

```
email:newemail@gmail.com
```

### Updating the clipboard timer
By default BashPass has a timer of `10` seconds. This can be changed in the config file located at `~/.config/bashpass/bashpass.conf`. To change this edit the following line.

```
timer:10
```

**Example**: if you want to update the timer to `15` seconds. You'll have to update the line to:

```
timer:15
```

## Feedback
This project isn't perfect, therefore suggestions/improvements are always [welcome](https://github.com/TuX-sudo/BashPass/issues)!
