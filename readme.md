Default user:root

Default password:1234


### 先在本地弄出一个文件夹###
执行下面的命令：
```bash
#debootstrap --verbose --arch=armhf --foreign stretch debian http://mirrors.ustc.edu.cn/debian/
#cd debian
#cp /usr/bin/qemu-arm-static usr/bin/
#LC_ALL=C LANGUAGE=C LANG=C chroot . /debootstrap/debootstrap --second-stage
#LC_ALL=C LANGUAGE=C LANG=C chroot . dpkg --configure -a
```


### chroot 并部署 rootfs： ###

```bash
#chroot .
#passwd root
#echo "Ntablet" > etc/hostname
#echo T0:2345:respawn:/sbin/getty -L ttyS2 115200 vt100 >> etc/inittab
#echo deb http://mirrors.ustc.edu.cn/debian/ stretch main contrib non-free > etc/apt/sources.list
#echo deb http://security.debian.org/ stretch/updates main contrib non-free >> etc/apt/sources.list
#apt-get update
#apt-get dist-upgrade
#apt-get install openssh-server
#apt-get install locales
#echo "en_US.UTF-8 UTF-8" > etc/locale.gen
#echo "zh_CN.UTF-8 UTF-8" >> etc/locale.gen
#locale-gen
#apt-get install wireless-tools wpasupplicant rfkill screen nano wget tar zip bluetooth blueman bluez bluez-tools libbluetooth-dev v4l-utils i2c-tools
#exit
```
建立img文件,这里以1G为例：
```bash
#dd if=/dev/zero of=./disk.img bs=1024 count=1000000
#fdisk ./disk.img
```
之后
```bash
n
回车
回车
w
```
格式化这个img
```bash
#mkfs.ext4 -F -L linuxroot disk.img
```

挂载：
#mkdir /tmp/rootfs
#mount ./disk.img /tmp/rootfs

进入刚刚的debian文件夹：
```bash
#tar --exclude=qemu-arm-static -cf - . | tar -C /tmp/rootfs -xvf -
#sync
```

缩小disk.img 的体积：
```bash
#umount /tmp/rootfs
#e2fsck -p -f ./disk.img
#resize2fs -M ./disk.img
```

把 debian cd里面的linux-ubuntu_rootfs.img 挂载,目的是拷贝某些设备的firmware驱动：
```bash
#mkdir /tmp/rootfs2
#mount ./linux-ubuntu_rootfs.img /tmp/rootfs2
#cp -R /tmp/rootfs2/system /tmp/rootfs/
#sync
```


最后，把这个disk.img烧录到机器里面，就完事了。

