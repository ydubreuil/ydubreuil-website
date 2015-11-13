+++
Categories = []
Description = ""
Tags = ["gpg", "pgp", "openpgp", "yukikey"]
date = "2015-07-20T18:54:48+02:00"
menu = "main"
title = "Renewing GPG keys"

+++

# Renewing GPG keys

## Useful links

* http://blog.josefsson.org/2014/06/19/creating-a-small-jpeg-photo-for-your-openpgp-key/
* http://blog.josefsson.org/2014/06/23/offline-gnupg-master-key-and-subkeys-on-yubikey-neo-smartcard/
* https://www.esev.com/blog/post/2015-01-pgp-ssh-key-on-yubikey-neo/
* https://help.riseup.net/en/security/message-security/openpgp/best-practices
* http://stafwag.github.io/blog/blog/2015/06/16/using-yubikey-neo-as-gpg-smartcard-for-ssh-authentication/

* http://anthon.home.xs4all.nl/rants/2014/setting_up_an_openpgp_smartcard_with_gnupg/

In French:

* https://linuxfr.org/news/openpgp-card-une-application-cryptographique-pour-carte-a-puce
* https://linuxfr.org/users/gouttegd/journaux/de-la-gestion-des-clefs-openpgp

## Hardware token

* https://www.nitrokey.com
* http://shop.kernelconcepts.de/
* http://wwww.yubico.com

## Pre-requisites

* LiveCD to be sure to generate keys on a clean system

  * [Tails](https://tails.boum.org/): based on Debian coming with GnuPG 2.0 known for its an
  * [Antergos](http://antergos.com/): based on ArchLinux coming with GnuPG 2.1 and the new

   pacman -S pcsclite ccid opensc libusb-compat # with daemon, activated by systemd socket (everything is magical, when it works....)
   systemctl enable pcscd.socket
   systemctl start pcscd.socket
* photo

  * http://blog.josefsson.org/2014/06/19/creating-a-small-jpeg-photo-for-your-openpgp-key/

* USB key to save the keystore: encrypted with LUKS

## Generating keys

```shell
mkdir gpg
gpg --homedir $HOME/gpg --expert --full-gen-key
```

## Manage secrets with Git / GPG

* https://github.com/StackExchange/blackbox

## Bonus

* https://www.ict.griffith.edu.au/anthony/info/crypto/encfs.hints
