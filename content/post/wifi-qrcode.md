+++
Categories = []
Description = ""
Tags = ["wifi", "qrcode"]
date = "2015-07-28T17:55:00+02:00"
title = "Generating a QR-Code for home Wifi access"

+++

# Generating a QR-code for home Wifi

On ArchLinux, install a QR code generator library

```shell
$ sudo pacman -S python2-qrcode
```

And then generates with

```shell
$ qr 'WIFI:S:<SSID>;T:<WPA|WEP|>;P:<password>;;' > qr-code.png
```

They should be readable with any [zxing](https://github.com/zxing/zxing) based reader.
