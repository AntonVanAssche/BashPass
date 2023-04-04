The BashPass configuration file can be found at `~/.config/bashpass/bashpass.conf`.
In this file, you can make several changes such as the email address, default location where passwords are stored, and other settings.
The default configuration file is shown below.

```
location: .local/share/bashpass
timer: 10
length: 14
```

## Configuring the Location where Passwords are Stored

By default, BashPass stores passwords in the directory `~/.local/share/bashpass/`.
If you want to change the location, you need to modify the following line in the config file:

```
location: .local/share/bashpass
```

**Example**: To store passwords in `.bashpass/passwords/`, update the line to:

**Note**: The new location must be within **your home** (`~`) directory.

```
location: .bashpass/passwords/
```

## Configuring the Email Address

It is not recommended to change the email address.
However, if you need to, update the following line in the config file:

```
email: email@gmail.com
```

**Example**: To update the email address to `newemail@gmail.com`, update the line to:

**Note**: After updating the email address, you need to generate a new GPG key.
You will also be unable to read your passwords that were stored with the old email address.

```
email: newemail@gmail.com
```

## Configuring the Clipboard Timer

By default, the timer for copying passwords is set to `10` seconds.
This timer is the duration you have to paste the password that you copied using the `copy` option.
You can modify the duration of the timer in the config file by editing the following line:

```
timer: 10
```

**Example**: To update the timer to `15` seconds, update the line to:

```
timer: 15
```


## Configuring the Default Password Length

The default length for all randomly generated passwords is `14` characters if no specific length is given when prompted (since version: `2.0`).
You can change this length to as many characters as you want by editing the following line in the config file:

```
length: 14
```


**Example**: To update the default password length to `25` characters, update the line to:

```
length: 25
```


## Configuring the Git Repository URL

If you want to use the `synchronize` functionality, you need to configure a URL that BashPass will use to push to the remote Git repository.
You can configure this by adding the following line to your config file:

```
gitRepo: <URL TO THE GIT REPOSITORY>
```


**Example**: To use `AntonVanAssche/BashPass` as the remote repository, update the line to:

```
gitRepo: git@github.com:AntonVanAssche/BashPass.git
```


**Note**: It is recommended to use the `SSH` option as shown above.
