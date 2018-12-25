passwd root
echo "RK3288" > etc/hostname
echo T0:2345:respawn:/sbin/getty -L ttyS2 115200 vt100 >> etc/inittab
echo deb http://mirrors.ustc.edu.cn/debian/ stretch main contrib non-free > etc/apt/sources.list
echo deb http://security.debian.org/ stretch/updates main contrib non-free >> etc/apt/sources.list
apt-get update
apt-get dist-upgrade
apt-get install openssh-server
apt-get install locales
echo "en_US.UTF-8 UTF-8" > etc/locale.gen
echo "zh_CN.UTF-8 UTF-8" >> etc/locale.gen
locale-gen
apt-get install wireless-tools wpasupplicant 
exit
ls
ls -la
apt-get update
cat etc/hostname 
echo "Ntablet" > etc/hostname
apt-get install v4l-utils
apt-get install i2c-tools
exit
ls
cd home
ls
passwd root
sync
exit
