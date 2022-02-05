# build-openwrt-rpi

# Create directory in your /home:
```
$ mkdir ~/openwrt
```

# Generate image:
```
$ docker build -t embarcados/build-openwrt .
```

# Running Container with -it --rm
```
$ docker run -it --rm --privileged --name build-openwrt -v $HOME/openwrt:/home/user/openwrt -v /tmp:/tmp -v /dev:/dev embarcados/build-openwrt /bin/bash
```

# Clone OpenWRT
```
user@81c8df85e7eb:~/openwrt$ git clone https://git.openwrt.org/openwrt/openwrt.git
Cloning into 'openwrt'...
remote: Enumerating objects: 588212, done.
remote: Counting objects: 100% (588212/588212), done.
remote: Compressing objects: 100% (157082/157082), done.
remote: Total 588212 (delta 411205), reused 583740 (delta 406886), pack-reused 0
Receiving objects: 100% (588212/588212), 171.55 MiB | 3.35 MiB/s, done.
Resolving deltas: 100% (411205/411205), done.
Checking connectivity... done.
user@81c8df85e7eb:~/openwrt$ 
user@81c8df85e7eb:~/openwrt$ cd openwrt/
user@81c8df85e7eb:~/openwrt/openwrt$ git checkout v21.02.1
```

# Update and Install Feeds
```
user@81c8df85e7eb:~/openwrt/openwrt$ ./scripts/feeds update -a
user@81c8df85e7eb:~/openwrt/openwrt$ ./scripts/feeds install -a
```

# Configuration TARGET and packages
```
user@81c8df85e7eb:~/openwrt/openwrt$ make menuconfig
```

# Options menuconfig
```
Target System --->
    (X) Broadcom BCM27xx

Subtarget --->
    (X) BCM2709/BCM2710/BCM2711 boards (32 bit)

Target Profile --->
    (X) Raspberry Pi 3B/3B+/3CM (32bit) (Raspberry Pi 2B/2B 1.2
    (X) Raspberry Pi 4B/400/4CM (32bit) (Raspberry Pi 2B/2B 1.2
    (X) Raspberry Pi 2B/2B 1.2 (32bit)

Administration --->
    <M> atop
    <*> htop

Kernel modules --->
    USB Support --->
        <*> kmod-usb-hid
        <*> kmod-usb2
        <*> kmod-usb3       

Languages --->
    Python --->
        <*> python3
        <*> python3-paho-mqtt
        <*> python3-ubus
        <*> python3-uci

Libraries --->
    <*> libssh
    <*> libssh2
    <*> libustream-openssl    

LuCI --->
    1. Collections --->
        <*> luci
        <*> luci-ssl-openssl

Utilities --->
    <*> psmisc
    <*> usbutils
```


# Starting build
```
user@81c8df85e7eb:~/openwrt/openwrt$ make -j$(nproc) V=s
...
...
...
Signing package index...
make[2]: Leaving directory '/home/user/openwrt/openwrt'
export MAKEFLAGS= ;make -w -r json_overview_image_info
make[2]: Entering directory '/home/user/openwrt/openwrt'
make[2]: Nothing to be done for 'json_overview_image_info'.
make[2]: Leaving directory '/home/user/openwrt/openwrt'
export MAKEFLAGS= ;make -w -r checksum
make[2]: Entering directory '/home/user/openwrt/openwrt'
make[2]: Leaving directory '/home/user/openwrt/openwrt'
make[1]: Leaving directory '/home/user/openwrt/openwrt'
```

# Writing image to microSD
```
user@81c8df85e7eb:~/openwrt/openwrt$ 
user@81c8df85e7eb:~/openwrt/openwrt$ cd bin/targets/bcm27xx/bcm2709/
user@81c8df85e7eb:~/openwrt/openwrt/bin/targets/bcm27xx/bcm2709$ ls
config.buildinfo
feeds.buildinfo
openwrt-bcm27xx-bcm2709-rpi-2-ext4-factory.img.gz
openwrt-bcm27xx-bcm2709-rpi-2-ext4-sysupgrade.img.gz
openwrt-bcm27xx-bcm2709-rpi-2.manifest
openwrt-bcm27xx-bcm2709-rpi-2-squashfs-factory.img.gz
openwrt-bcm27xx-bcm2709-rpi-2-squashfs-sysupgrade.img.gz
packages
sha256sums
version.buildinfo
user@81c8df85e7eb:~/openwrt/openwrt/bin/targets/bcm27xx/bcm2709$ 
user@81c8df85e7eb:~/openwrt/openwrt/bin/targets/bcm27xx/bcm2709$ sudo gzip -dc openwrt-bcm27xx-bcm2709-rpi-2-ext4-factory.img.gz | sudo dd of=/dev/mmcblk0 bs=1M conv=fsync
0+5632 registros de entrada
0+5632 registros de saída
184549376 bytes (185 MB, 176 MiB) copied, 18,1345 s, 10,2 MB/s
```


# Have fun!
```bash
:-)
```

# Contact
You can contact me by email at cleitonrbueno@gmail.com
