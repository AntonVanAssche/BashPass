# BashPass

BashPass is a password manager written in Bash. It uses GPG to encrypt/decrypt the files where the passwords are stored (default: `~/.local/share/bashpass/`). This means the password are 100% stored locally, so you don't have to trust a third party to store your passwords.

## Table of contents

-  [Dependencies](#dependencies)
-  [Usage](#usage)
-  [Installing BashPass](#installing-bashpass)
   -  [Generating your GPG key](#generating-your-gpg-key)
   -  [Running the installer](#running-the-installer)
-  [Updating BashPass](#updating-bashpass)
-  [Uninstalling BashPass](#uninstalling-bashpass)
-  [Synchronize passwords between devices](#synchronize-passwords-between-devices)
   -  [Upload](#upload)
   -  [Download](#download)
-  [Configuring BashPass](#configuring-bashpass)
   -  [Configuring the location where passwords are stored](#configuring-the-location-where-passwords-are-stored)
   -  [Configuring the email address](#configuring-the-e-mail-address)
   -  [Configuring the clipboard timer](#configuring-the-clipboard-timer)
   -  [Configuring the default password length](#configuring-the-default-password-length)
-  [Feedback](#feedback)

## Dependencies

-  `bash >= 3.0`

**Password encryption**:

-  `gpg` or `gpg2`

**Clipboard support**:

-  `xclip`

**Synchronization support**:

-  `rsync`
-  `openssh`

## Usage

**Note**: the `[name]` is optional.

```
bashpass [option] [name]                    - Basic command structure.

Options:
--help     or -h                            - Show this help message.
--version  or -v                            - Show the version number
--list     or -l                            - List all password.
--add      or -a                     [name] - Add a password.
--update   or -u                     [name] - Update a password.
--delete   or -d                     [name] - Delete a password.
--show     or -s                     [name] - Show a password.
--copy     or -c                     [name] - Copy a password to the clipboard.
--sync     or -S  [upload|download]  [name] - Synchronize a password with a other device on your local network.
```

Examples:

-  `bashpass --add gmail`
-  `bashpass --delete gmail`
-  `bashpass --show gmail`
-  `bashpass --list`

## Installing BashPass

### Generating your GPG key

Before you install BashPass, you'll have to generate a GPG key. Run the following command in your terminal to start key generation process.

```bash
$ gpg --full-generate-key
```

Once you run this command, you'll be asked to select a encryption protocol. Select the first option (`RSA`).

```
Please select what kind of key you want:
   (1) RSA and RSA
   (2) DSA and Elgamal
   (3) DSA (sign only)
   (4) RSA (sign only)
   (9) ECC (sign and encrypt) *default*
  (10) ECC (sign only)
  (14) Existing key from card
Your selection? 1
```

Now you'll be prompted to choose a keysize. The default option (`3072`) is fine.

```
RSA keys may be between 1024 and 4096 bits long.
What keysize do you want? (3072)
Requested keysize is 3072 bits
```

After selecting the keysize, you'll be asked how long you want the key to be valid. The default option 1 (`key does not expire`) is fine.

```
Please specify how long the key should be valid.
         0 = key does not expire
      <n>  = key expires in n days
      <n>w = key expires in n weeks
      <n>m = key expires in n months
      <n>y = key expires in n years
Key is valid for? (0)
Key does not expire at all
Is this correct? (y/N) y
```

Now it's time to set a name for the key. This can be anything (example: BashPass) but it's important to remember, you'll need this later to configure BashPass.

```
Real name: Bashpass
```

Once you've set a name for the key, it's time to set the email address. Again this is important to remember, you'll need this later to configure BashPass.

```
Email address: example@gmail.com
```

The final step to generate your GPG key is to set a comment, this isn't needed but can be useful in case you have more than one GPG key on your computer. After this just confirm the setting and you're done.

```
Comment: BashPass encryption key
```

### Running the installer

Once you have generated your GPG key, it's time to install BashPass. For this you can clone the repo and run the `install.sh` script or the simple one-liner below. This command will download the latest version of BashPass and install it for you.

```bash
$ bash -c "$(wget -qO - https://raw.githubusercontent.com/AntonVanAssche/BashPass/master/scripts/install.sh)"
```

After installation, you'll have to add `.local/bin` to your PATH to use BashPass. Add the following line in your `.bashrc` file.

```bash
export PATH="$HOME/.local/bin:$PATH"
```

When you start BashPass for the first time you'll be prompted with the question to enter the name of the GPG key you want to use. After entering the name a you'll be asked to enter the e-mail address you've used to generate the key.

```
Enter the name of the GPG key you want to use: Bashpass
Enter the email address you created the gpg key with: example@gmail.com
```

## Updating BashPass

To update BashPass to the latest version, you can clone the repo and run the `update.sh` script or the simple one-liner below.

```bash
$ bash -c "$(wget -qO - https://raw.githubusercontent.com/AntonVanAssche/BashPass/master/scripts/update.sh)"
```

## Uninstalling BashPass

To uninstall BashPass, you can clone the repo and run the `uninstall.sh` script or the simple one-liner below.

```bash
$ bash -c "$(wget -qO - https://raw.githubusercontent.com/AntonVanAssche/BashPass/master/scripts/uninstall.sh)"
```

## Synchronize passwords between devices

The `sync` option of BashPass allows you to upload or download a password from your device to another device on your local network using `ssh` and `rsync`. This option can used like shown below.

**Note**: you'll have to import/export your GPG keys to/from the other device. You can follow [this guide](https://www.debuntu.org/how-to-importexport-gpg-key-pair/) for importing and exporting your GPG keys,

### Upload

To upload a password to another device on your local network, run the following command.

**Note**: this will upload the password to the default location (`~/.local/share/bashpass/`).

```bash
$ bashpass --sync upload password
```

In case you want to upload all your passwords to another device, you can run the following command.

```bash
$ bashpass --sync upload all
```

### Download

To download a password from another device on your local network, run the following command.

**Note**: this will download the password from the default location (`~/.local/share/bashpass/`).

```bash
$ bashpass --sync download password
```

In case you want to upload all your passwords to another device, you can run the following command.

```bash
$ bashpass --sync download all
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
