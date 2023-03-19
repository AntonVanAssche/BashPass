## Dependencies

-  `bash >= 3.0`

**Password encryption**:

-  `gpg` or `gpg2`

**Clipboard support**:

-   X11
    -  `xclip` or `xsel`
-   Wayland
    -   _Comming soon_

**Synchronization support**:

-  `git`

## Installation

### Generating your GPG key

Before you install BashPass, you'll have to generate a GPG key.
Run the following command in your terminal to start key generation process:

```console
$ gpg --full-generate-key
```

Once you run this command, you'll be asked to select a encryption protocol.
Select the first option (`RSA`).

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

Now you'll be prompted to choose a keysize.
The default option (`3072`) is fine, for a stronger key select `4096`.

```
RSA keys may be between 1024 and 4096 bits long.
What keysize do you want? (3072)
Requested keysize is 3072 bits
```

After selecting the keysize, you'll be asked how long you want the key to be valid.
The default option 1 (`key does not expire`) is fine.

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

Now it's time to set a name for the key.
This can be anything (example: `BashPass`).

```
Real name: Bashpass
```

Once you've set a name for the key, it's time to set the email address, this is **IMPORTANT** to remember, you'll need this later to configure BashPass.

```
Email address: example@gmail.com
```

The final step to generate your GPG key is to set a comment, this isn't needed but can be useful in case you have more than one GPG key on your computer.
After this just confirm the settings and you're done.

```
Comment: BashPass encryption key
```

Now your key will be generated.
Once this is done you'll see something like this:

```
pub   rsa3072 2022-04-22 [SC]
      86F27E3CAA49BB273653B39763BBB2BD91082EE1
uid           [ultimate] Bashpass (Key to use BashPass) <example@gmail.com>
sub   rsa3072 2022-04-22 [E]
```

Note you can see the key fingerprint (`86F27E3CAA49BB273653B39763BBB2BD91082EE1``), this string contains the key ID.
This are the last 8 characters (`91082EE1`) of the fingerprint.
This part is **IMPORTANT** to remember, you'll need this later to configure BashPass (see: [Post installation](#post-installation)).

### Installation using the installer (recommended)

Once you have generated your GPG key, you can proceed to install BashPass.
The recommended way to install BashPass is to use the installer script.
You can clone the repository and run the install.sh script, or you can run the following one-liner command in your terminal:

```console
$ bash -c "$(wget -qO - https://raw.githubusercontent.com/AntonVanAssche/BashPass/master/scripts/install.sh)"
```

If the above command fails, you can try using `curl` instead of `wget` by running the following command:

```console
$ bash -c "$(curl -so - https://raw.githubusercontent.com/AntonVanAssche/BashPass/master/scripts/install.sh)"
```

If neither of these options work, it may be because you do not have either `wget` or `curl` installed on your system.
You can check if you have either of them installed by running `command -v wget` or `command -v curl`, which should return the path where the binary is located.
If you don't have either of them installed, you can install them using your system's package manager.

### Installation using the tarball/zip

If you prefer to manually install BashPass, you can do so using the tarballs (or zip) available on the [release page](https://github.com/AntonVanAssche/BashPass/releases/latest/) of the BashPass GitHub repository.
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
A copy of this public key can be found on the [release](https://github.com/AntonVanAssche/BashPass/releases/download/2.0/BashPass-2.0.pub) page.
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
gpg: assuming signed data in 'BashPass-2.0.tar.gz'
gpg: Signature created Sat April 23 18:37:51 2022 CEST
gpg: Use RSA key AB592CC1A4D17E654ED55FE83FF8016D27683E3E
gpg: Good signature of "Anton Van Assche (git) <vanasscheanton@gmail.com>" [unknown]
```

Now it's time to extract the tarball, you can do this with the following command:

```console
$ tar -xvzf BashPass-X.X.tar.gz
```

Once the tarball is extracted, it is time to create the necessary folders and copy all the files to the their corresponding directory.

```console
$ mkdir -p ~/.config/bashpass/
$ mkdir -p ~/.local/share/bashpass/
$ mkdir -p ~/.local/bin/
$ cp -r BashPass-X.X/bashpass ~/.local/bin/
$ cp -r BashPass-X.X/config/ ~/.config/bashpass/
```

### Post installation

After installing BashPass, you need to add `.local/bi`n to your `PATH` variable in order to use it.
To do so, add the following line to your .bashrc file:

```bash
export PATH="${HOME}/.local/bin:${PATH}"
```

When you launch BashPass for the first time, you will be asked to enter the key ID and email address associated with the GPG key that you generated (see: [Generating your gpg key](#generating-your-gpg-key)).

```
Enter the key ID of the GPG key you want to use: 91082EE1
Enter the email address you created the gpg key with: example@gmail.com
```

That's it, you can now start using BashPass!

## Updating

To update BashPass to the latest version, you can clone the repository and run the `update.sh` script, or you can use the one-liner below to download and install the latest version:

```console
$ bash -c "$(wget -qO - https://raw.githubusercontent.com/AntonVanAssche/BashPass/master/scripts/update.sh)"
```

If you don't have `wget`, you can use `curl` instead:

```console
$ bash -c "$(curl -so - https://raw.githubusercontent.com/AntonVanAssche/BashPass/master/scripts/update.sh)"
```

If both options fail, you may need to install one of these tools first.
To check whether `wget` or `curl` is installed, run `command -v wget` or `command -v curl` respectively.
This should return the path to the binary.

## Uninstalling

To uninstall BashPass, you can clone the repository and run the `uninstall.sh` script, or you can use the one-liner below to remove your current installation:

```console
$ bash -c "$(wget -qO - https://raw.githubusercontent.com/AntonVanAssche/BashPass/master/scripts/uninstall.sh)"
```

If you don't have `wget`, you can use `curl` instead:

```console
$ bash -c "$(curl -so - https://raw.githubusercontent.com/AntonVanAssche/BashPass/master/scripts/uninstall.sh)"
```

If both options fail, you may need to install one of these tools first.
To check whether `wget` or `curl` is installed, run `command -v wget` or `command -v curl` respectively.
This should return the path to the binary.
