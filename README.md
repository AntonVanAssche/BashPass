# BashPass
A simple password manager written in Bash.

## Dependencies
- gpg

## Usage
Note: the `[name]` is optional.

```
bashpass [add|delete|show|list] [name] - Basic commands

help                                   - Show this help message.
version                                - Show the version number
add                             [name] - Add a password.
delete                          [name] - Delete a password.
show                            [name] - Show a password.
list                                   - List all password.
```

Examples: 
- `bashpass --add gmail`
- `bashpass --delete gmail`
- `bashpass --show gmail`
- `bashpass --list`

## Installation
First you'll have to generate a GPG key. Run the following command to do so, and your key will be generated (you can use the defaults for most questions)

```bash
$ gpg --full-generate-key
```

Now it's time to install BashPass. Just run the `install.sh` script and you'll be good to go

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

## Feedback
This project isn't perfect, therefore suggestions/improvements are always [welcome](https://github.com/TuX-sudo/BashPass/issues)!
