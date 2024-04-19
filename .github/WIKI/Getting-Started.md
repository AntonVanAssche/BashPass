This page provides instructions on how to get started with BashPass.
It covers the installation, updating, and uninstalling of BashPass.
As well as the prerequisites and dependencies required to run BashPass.

# 1. Dependencies

-   `bash >= 3.0`

**Password encryption**:

-   `gpg` or `gpg2`

**Clipboard support**:

-   X11
    -   `xclip` or `xsel`
-   Wayland
    -   `wl-clipboard`
-   macOS
    -   `pbcopy`

**Synchronization support**:

-   `git`

# 2. Installation

## 2.1 Generating your GPG key

Before you install BashPass, you'll have to generate a GPG key:

```console
$ gpg --full-generate-key
```

Select the first option (`RSA`):

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

Enter the keysize, the default option (`3072`) is fine, for a stronger key select `4096`:

```
RSA keys may be between 1024 and 4096 bits long.
What keysize do you want? (3072)
Requested keysize is 3072 bits
```

Enter time to expire, the default option (`0`) is fine:

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

Choose a name for the key, this can be anything you like:

```
Real name: Bashpass
```

Enter the email address you want to use:

```
Email address: example@gmail.com
```

Finally, enter a comment, this can be anything you like, empty is fine:

```
Comment: BashPass encryption key
```

Once all the options are set, you should a see a message like this:

```
pub   rsa3072 2022-04-22 [SC]
      86F27E3CAA49BB273653B39763BBB2BD91082EE1
uid           [ultimate] Bashpass (Key to use BashPass) <example@gmail.com>
sub   rsa3072 2022-04-22 [E]
```

Within the output, you will find the key fingerprint, in this case `86F27E3CAA49BB273653B39763BBB2BD91082EE1`.
From this fingerprint, you can extract the key ID, in this case `91082EE1`, which we will use later.

## 2.2 Installation By downloading the tarball/zip (recommended)

If you prefer to download the provided tarball or zip, you can download them from the [release page](https://github.com/AntonVanAssche/BashPass/releases/latest/) of the GitHub repository.
This is the recommended way to install BashPass, since it allows you to verify the authenticity of the tarball.
Follow the steps below to manually install BashPass:

Download the tarball corresponding to the version you want to install from the [release page](https://github.com/AntonVanAssche/BashPass/releases/latest/).

**Note**: Replace `X.X` in the commands below with the version number you want to install.

```console
$ wget -O BashPass-X.X.tar.gz https://github.com/AntonVanAssche/BashPass/archive/refs/tags/X.X.tar.gz
$ wget -O BashPass-X.X.tar.gz.asc https://github.com/AntonVanAssche/BashPass/releases/download/X.X/BashPass-X.X.tar.gz.asc
```

If the above commands fail, you can try using `curl` instead of `wget` by running the following commands:

```console
$ curl -o BashPass-X.X.tar.gz -L https://github.com/AntonVanAssche/BashPass/archive/refs/tags/X.X.tar.gz
$ curl -o BashPass-X.X.tar.gz.asc -L https://github.com/AntonVanAssche/BashPass/releases/download/X.X/BashPass-X.X.tar.gz.asc
```

If neither of these options work, it may be because you do not have either `wget` or `curl` installed on your system.
You can check if you have either of them installed by running `command -v wget` or `command -v curl`, which should return the path where the binary is located.
If you don't have either of them installed, you can install them using your system's package manager.

The provided tarballs are signed with the following PGP key: [AB592CC1A4D17E654ED55FE83FF8016D27683E3E](https://keyserver.ubuntu.com/pks/lookup?search=0x3ff8016d27683e3e&op=vindex).
A copy of this public key can be found on the [release](https://github.com/AntonVanAssche/BashPass/releases/download/3.0/BashPass-3.0.pub) page.
This key allows you to verify the tarball.
Although this step isn't required, it is recommended.
If you do decide to verify the authenticity of the tarball you can import the PGP key by using this command:

```console
$ gpg --keyserver keyserver.ubuntu.com --recv-keys 0x3ff8016d27683e3e
```

Once the PGP key is imported, you can verify the authenticity of the tarball.

```console
$ gpg --verify BashPass-X.X.tar.gz.asc
```

This command verifies the tarball's signature using GPG. If the signature is valid, you should see a message indicating that the signature is good, as shown below.

```
gpg: assuming signed data in 'BashPass-X.X.tar.gz'
gpg: Signature created Sat April 23 18:37:51 2022 CEST
gpg: Use RSA key AB592CC1A4D17E654ED55FE83FF8016D27683E3E
gpg: Good signature of "Anton Van Assche (git) <vanasscheanton@gmail.com>" [unknown]
```

Now it's time to extract the tarball, you can do this with the following command:

```console
$ tar -xvzf BashPass-X.X.tar.gz
```

Once the tarball is extracted, it is time to install BashPass, by using the `make install` command.

```console
$ cd BashPass-X.X

# Linux and macOS
$ sudo make install

# BSD
$ doas make install
```

## 2.3 Installation by cloning the repository

Once you have generated your GPG key, you can proceed to install BashPass.
BashPass can be installed by cloning the repository and running the `make install` command as a privileged user.

**Note**: Replace `X.X` in the commands below with the version number you want to install.

```console
$ git clone https://www.github.com/AntonVanAssche/BashPass.git --branch X.X
$ cd BashPass-X.X

# Linux and macOS
$ sudo make install

# BSD
$ doas make install
```

## 2.4 Post installation

Upon first run, BashPass will ask you to enter the key ID associated with the GPG key you generated (see: [Generating your gpg key](#generating-your-gpg-key)).

```
Enter the key ID associated with your GPG key: 91082EE1
```

That's it, you can now start using BashPass!

# 3.0 Updating

To update BashPass, you can follow the same steps as the installation process.

# 4.0 Uninstalling

Uninstalling BashPass is also fairly straightforward, `make uninstall` can be used to remove BashPass from your system.

```console
# Linux and macOS
$ sudo make uninstall

# BSD
$ doas make uninstall
```

Alternatively, you can uninstall BashPass by running the following commands as a privileged user:

-   For Linux and BSD:

```console
$ rm -rf /usr/bin/bashpass
$ rm -rf /usr/share/man/man1/bashpass.{1,conf.1}.gz
```

-   For macOS:

```console
$ rm -rf /usr/local/bin/bashpass
$ rm -rf /usr/local/share/man/man1/bashpass.{1,conf.1}.gz
```
