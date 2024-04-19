This page provides instructions on how to configure BashPass using its configuration file.

# 1. Configuration File

By default, BashPass will look for a configuration file in `~/.config/bashpass/bashpass.conf`.
If the file is not found, BashPass will use the default settings.

```
location: .local/share/bashpass
timer: 10
length: 14
```

# 2. Configuring BashPass

You can configure BashPass by editing the configuration file.
The configuration file is a simple text file that contains the following settings:

## 2.1. GnuPG Key ID

Upon first use, BashPass will ask you to provide your GnuPG key ID and will store it in the configuration file.
In order to make BashPass work, you need to provide your GnuPG key ID.
This can be done by adding an entry to the configuration, using `keyID` as the key and your GnuPG key ID as the value.
The key ID of a GnuPG key is the last 8 characters of the key fingerprint.

For example, using `12345678` as the ID will look like this:

```
keyID: 12345678
```

## 2.2 Password Length

BashPass allows you to set a default password length, which it will use when generating passwords.
Out of the box, BashPass will generate passwords with a length of `14` characters.
Once set, you can still override this value when generating passwords.

For example, to change the default password length to `16`, you can add the following entry to the configuration file:

```
length: 16
```

## 2.3 Password Store Location

BashPass will store all password files in a specified location, also known as the password store.
This location must be present in your home directory (`~`).
By default, the password store is located in `~/.local/share/bashpass`.


For example, to change the passowrd store location to `~/.passwords`, you can add the following entry to the configuration file:

**Note**: The password store location may not include the `~` character. As its added by BashPass.

```
location: .passwords
```

## 2.4 Timer

When using the `-c` or `--copy` option, BashPass will clear the clipboard after a specified amount of time.
This time is specified in seconds, and defaults to `10` seconds.
However, adding an `timer` entry to the configuration file will allow you to change the default value.

For example, to change the default timer to `5` seconds, you can add the following entry to the configuration file:

```
timer: 5
```
