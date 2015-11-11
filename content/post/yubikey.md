+++
Categories = []
Description = ""
Tags = ["yubikey", "gpg"]
date = "2015-11-11T11:55:00+02:00"
menu = "main"
title = "Configure the YukiKey on ArchLinux"
+++

# Configure the YukiKey on ArchLinux

A few months ago, I bought a [YubiKey Neo](https://www.yubico.com/products/yubikey-hardware/) to secure my PGP key and my GMail account with 2FA.
I also use it to authenticate SSH access (for Github commit mostly).
It means no more private keys living on my hard drive!

There are many good resources available out there explaining how everything works:

* http://blog.josefsson.org/2014/06/23/offline-gnupg-master-key-and-subkeys-on-yubikey-neo-smartcard/
* https://www.esev.com/blog/post/2015-01-pgp-ssh-key-on-yubikey-neo/
* http://stafwag.github.io/blog/blog/2015/06/16/using-yubikey-neo-as-gpg-smartcard-for-ssh-authentication/
* https://wiki.archlinux.org/index.php/GnuPG

This post is just a quick and dirty procedure to enable YubiKey.

## System configuration

* Create `/etc/udev/rules.d/70-u2f.rules`

```
# this udev file should be used with udev 188 and newer
ACTION!="add|change", GOTO="u2f_end"

KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="1050", ATTRS{idProduct}=="0113|0114|0115|0116|0120|0402|0403|0406|0407|0410", TAG+="uaccess"

LABEL="u2f_end"
```

* Install required packages

```shell
$ sudo pacman -S libusb-compat pcsclite ccid
```

* Activate PCSC-lite daemon

```shell
$ sudo systemctl enable pcscd.socket
```

* Reload udev and start PCSC-lite daemon / Reboot if your prefer to be sure everything's okay

```shell
$ sudo udevadm control --reload
$ sudo systemctl start pcscd.socket
```

* Check that everything's set up correctly

```shell
$ gpg --card-status

Application ID ...: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
Version ..........: 2.0
Manufacturer .....: Yubico
Serial number ....: XXXXXXXXXXXXXX
Name of cardholder: Yoann Dubreuil
Language prefs ...: en
Sex ..............: unspecified
URL of public key : https://pgp.mit.edu/pks/lookup?op=vindex&search=0x689E687C72422C96
Login data .......: dudu
Signature PIN ....: forced
Key attributes ...: rsa2048 rsa2048 rsa2048
Max. PIN lengths .: 127 127 127
PIN retry counter : 3 3 3
Signature counter : 2
Signature key ....: 04F4 C62E 2C07 A00E 15DF  46FE 1163 4204 03E3 2C98
      created ....: 2015-07-20 21:29:58
Encryption key....: 3485 8FB6 DA6A 9918 A1C2  2D3D 3C8E 0E34 5EB3 66DF
      created ....: 2015-07-20 21:30:31
Authentication key: B0B8 47E8 1954 C25B F2E7  9019 74F6 4468 C691 150B
      created ....: 2015-07-20 21:31:06
General key info..: sub  rsa2048/03E32C98 2015-07-20 Yoann Dubreuil <XXXXXXXXXXXX>
sec#  rsa4096/72422C96  created: 2015-07-20  expires: 2020-07-18
ssb>  rsa2048/03E32C98  created: 2015-07-20  expires: 2017-07-19
                        card-no: 0006 XXXXXXXX
ssb>  rsa2048/5EB366DF  created: 2015-07-20  expires: 2017-07-19
                        card-no: 0006 XXXXXXXX
ssb>  rsa2048/C691150B  created: 2015-07-20  expires: 2017-07-19
                        card-no: 0006 XXXXXXXX
```

### Configure GPG agent for SSH authentication

* If you use Gnome Keyring, disable it first:

```shell
$ cp /etc/xdg/autostart/gnome-keyring-ssh.desktop ~/.config/autostart/gnome-keyring-ssh.desktop
$ sed -i 's/X-GNOME-AutoRestart=true/X-GNOME-AutoRestart=false/' ~/.config/autostart/gnome-keyring-ssh.desktop
```

* Add this line in `~/.gnupg/gpg-agent.conf`

```
enable-ssh-support
```

* Generate SSH public key from GPG key. SSH doesn't know what to do with GPG public key, so we need to convert the GPG public key to SSH format with

```shell
$ gpgkey2ssh
```

* Define `SSH_AUTH_SOCK` for your Unix session by adding this line in `.pam_environment` ([example](https://github.com/ydubreuil/dotfiles/blob/master/pam_environment#L16))

```
SSH_AUTH_SOCK DEFAULT="/home/UNIX_USER/.gnupg/S.gpg-agent.ssh"
```

Note: Use a `TAB` character between `SSH_AUTH_SOCK` and `DEFAULT`, not a space character.
