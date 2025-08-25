# boot0cfg -B ada0 # install boot0 sur le MBR
# boot0cfg -s 1 ada0 # définit la slice 1 par défaut
# boot0cfg -t 1200 ada0 # règle le timeout en ticks (~ 18e de seconde)
# bootx64.efi # à lancer dans le shell efi pour lancer l’installation si pas automatique
# sxhkd -m 1 # ???
VBoxClient --display
VBoxClient-all
acpiconf -i 0
acpiconf -s 3 # sleep
bectl list
bsdinfo
camcontrol devlist # cd, dvd, usb key
cd /usr/local/share/bastille
chanson=local && mpc -f "%file%"
chflags -v noschg /usr/jails/yinyang.antra/var/empty
chpass user
chsh -s /usr/local/bin/zsh
cle=agent ; eval $(ssh-agent)
cle=liste ; ssh-add -l
cle=ssh-local ; ssh-add ~/racine/config/cmdline/ssh/$HOST/id_rsa
cp /boot/loader.efi /boot/efi/EFI/boot/bootx64.efi
dbus-launch waybar
demonte=cleusb ; umount /media/da0s1
devinfo -rv
dmesg
dmesg | grep CPU:
doas -s
doas /etc/rc.d/sysctl reload
doas adduser
doas bastille bootstrap 13.2-RELEASE update
doas bastille cmd ALL ps aux
doas bastille cmd temple sockstat -4
doas bastille console tower
doas bastille create -B tower-dhcp 14.0-RELEASE 0.0.0.0 bridge0
doas bastille create temple 14.3-RELEASE 192.168.1.250/24
doas bastille create tower 13.2-RELEASE 192.168.1.250 wlan0
doas bastille list
doas bastille list release
doas bastille service temple sshd start
doas bastille start tower
doas bastille stop tower
doas bastille sysrc temple sshd_enable=YES
doas bastille update 13.2-RELEASE
doas bastille verify 13.2-RELEASE
doas beadm create new-snapshot
doas beadm destroy old-snapshot
doas beadm list
doas bectl activate vanilla
doas bectl mount vanilla /mnt
doas bsdconfig
doas bsdinstall auto
doas bsdinstall netconfig
doas cap_mkdb /etc/login.conf
doas cd /usr/ports/multimedia/vlc && make install-missing-packages
doas chmod 0600 /usr/local/etc/ssl/keys
doas chmod 0600 /usr/local/etc/ssl/keys/poudriere.key
doas chroot /compat/ubuntu /bin/bash
doas debootstrap focal /compat/ubuntu
doas echo 'FreeBSD: { url: "pkg+http://pkg.FreeBSD.org/${ABI}/latest" }' > /usr/local/etc/pkg/repos/FreeBSD.conf
doas ezjail-admin create yinyang.antra 'lo1|127.0.1.1,fxp0|192.168.1.100'
doas ezjail-admin install
doas ezjail-admin start yinyang.antra
doas ezjail-admin stop yinyang.antra
doas freebsd-update -r 13.0-RELEASE upgrade
doas freebsd-update fetch
doas freebsd-update install
doas git clone https://git.freebsd.org/ports.git --branch main /usr/ports
doas gitup ports
doas gpart bootcode -b /boot/pmbr -p /boot/gptzfsboot -i 1 ada0 # legacy bios ???
doas gpart bootcode -p /boot/boot1.efi -i 1 ada0 # efi ???
doas ifconfig wlan0 create wlandevice iwn0
doas ifconfig wlan0 list scan
doas ifconfig wlan0 scan
doas ifconfig wlan0 up
doas jexec j-name /bin/sh
doas jexec tower df -h
doas kldload coretemp
doas kldload ext2fs
doas kldload ipmi
doas kldload vboxguest
doas mdconfig -a -t vnode -f swapfile -u 0
doas mdconfig -l -v
doas mkdir -p /usr/local/etc/pkg/repos
doas mkdir -p /usr/local/etc/ssl/{certs,keys}
doas mount_msdosfs /dev/da0s1 /media
doas mount_vboxvfs -w virtualbox-share /mnt
doas networkmgr
doas ntpdate -v -b in.pool.ntp.org
doas ntpq -pn
doas openssl genrsa -out /usr/local/etc/ssl/keys/poudriere.key 4096
doas openssl rsa -in /usr/local/etc/ssl/keys/poudriere.key -pubout -out /usr/local/etc/ssl/certs/poudriere.cert
doas pfctl -d
doas pkg bootstrap
doas pkg bootstrap -f
doas pkg install -r custom-repo some-package
doas pkg install -y bastille
doas pkg install -y pkg-provides pkg-rmleaf
doas pkg install -y poudriere nginx memcached portmaster groff
doas pkg install -y vim
doas pkg install avahi-app nss_mdns
doas pkg install debootstrap
doas pkg install lightdm lightdm-gtk-greeter
doas pkg install linux-browser-installer
doas pkg install networkmgr
doas pkg install xorg xf86-video-intel
doas pkg lock -l
doas pkg provides -u
doas pkg update
doas pkg update -f
doas pkg upgrade
doas portsnap extract
doas portsnap fetch
doas portsnap update
doas poudriere bulk -j 13-2-R-amd64 -f /usr/local/etc/poudriere.d/liste-de-paquets -p HEAD
doas poudriere jail -c -j 13-2-R-amd64 -v 13.2-RELEASE
doas poudriere jail -u -j 13-2-R-amd64
doas poudriere options -c -j 13-2-R-amd64 -f /usr/local/etc/poudriere.d/liste-de-paquets
doas poudriere ports -c -m git+https -B main -p HEAD
doas poudriere ports -u
doas pw groupmod audio -m user_name
doas pw groupmod operator -m user_name
doas pw groupmod video -m user_name
doas pw groupmod wheel -m user_name
doas pw usermod toor -u 0
doas pw usermod user_name -G wheel,operator,video,audio
doas service automount restart
doas service automount start
doas service automountd start
doas service autounmountd start
doas service avahi-daemon enable
doas service avahi-daemon restart
doas service bastille enable
doas service dbus enable
doas service dbus onestart
doas service dbus restart
doas service dbus onerestart
doas service dbus start
doas service devd restart
doas service devfs restart
doas service dhclient restart fxp0
doas service ezjail restart
doas service netif cloneup
doas service netif restart
doas service nginx enable  #doas
doas service virtual_oss enable
doas shutdown -h now
doas swapinfo -h
doas swapinfo -k
doas swapon -aL
doas swapon /dev/md0
doas sysctl debug.acpi.suspend_bounce=1  # before testing suspend
doas sysctl dev.pcm.0.play.vchans=4
doas sysctl dev.pcm.0.rec.vchans=4
doas sysctl hw.snd.maxautovchans=4
doas sysctl vfs.usermount=1
doas sysrc bastille_enable=YES
doas sysrc cloned_interfaces+=lo1
doas sysrc ezjail_enable="YES"
doas sysrc ifconfig_lo1_name="bastille0"
doas sysrc ifconfig_wlan0="WPA DHCP"
doas sysrc keymap="us.kbd"
doas sysrc powerd_enable=YES
doas sysrc wlans_ath0="wlan0"
doas truncate -s 8G swapfile
doas usbconfig
doas vim /usr/local/etc/bastille/bastille.conf
doas zfs create -o canmount=noauto -o mountpoint=/ zroot/ROOT/vanilla
doas zfs create -o mountpoint=/usr/local/poudriere zroot/poudriere
doas zfs create cle-usb/compressed
doas zfs diff cle-usb/compressed@initial
doas zfs list -rt all
doas zfs set compression=gzip cle-usb/compressed
doas zfs snapshot cle-usb/compressed@initial
doas zfs unmount cle-usb
doas zfs unmount cle-usb/compressed
doas zpool create cle-usb /dev/da4
doas zpool create zmirror /dev/da0 /dev/da1
doas zpool resilver zroot
doas zpool scrub -s zroot
doas zpool scrub -w zroot
doas zpool scrub zroot
doas zpool upgrade -a
doas zpool upgrade pool-name
ext4fuse /dev/da4s1 ~/tremplin/usbdrive
find ~/photo -type f -links +1 L
find ~/photo -type f -printf '%n %p\n' | awk '$1 > 1 {$1="";print}'
find ~/photo -type f \! -links 1 L
fondecran=1 ; pkill fond-ecran.zsh ; sleep 1 ; fond-ecran.zsh 12 84 ~/graphix/list/wallpaper.gen >>! ~/log/fond-ecran.log &!
freebsd-version
freebsd-version -k ; uname -r
gem install --user-install neovim
getfacl fichier
gmirror label -v gm0 /dev/da0 /dev/da1
gmirror load
gpart show
jls
kbdmap # console virtuelle, root
kldstat
kldstat -v
ls -l `find ~/photo -type f -links +1` L
ls /boot/kernel | grep -v kernel
lsblk
make search name=xzgv L
mixer vol 70
mixertui
mkdir=run-media ; doas mkdir -p /run/media/user_name
monte=cleusb ; mount -t msdosfs -o -m=644,-M=755 /dev/da0s1 ~/usbkey
monte=cleusb ; mount -t msdosfs /dev/da0s1 /media/da0s1
monte=cleusb ; udevil mount /dev/sdb1 /media/cleusb
monte=diskext-sdb1 ; udevil mount /dev/sdb1 /run/media/user_name/sdb1
monte=sdb1 ; udevil mount /dev/sdb1 /run/media/user_name/sdb1
mpliste=Detente ; droits-audio.zsh ; mpc --wait update ; mpc crop ; mpc load $mpliste ; mpc play
mpliste=Meditation ; droits-audio.zsh ; mpc --wait update ; mpc crop ; mpc load $mpliste ; mpc play
mpliste=Tout ; droits-audio.zsh ; mpc --wait update ; mpc crop ; mpc load $mpliste ; mpc play
netstat -rn
networkmgr &
nmcli dev wifi
passwd root
passwd toor
pciconf -clv
pciconf -lv
pciconf -lv | grep -A1 -B3 network
pgrep -lf vim
pip3 install --user --upgrade neovim
pip3 install --user --upgrade pip
pkg info -l devel/ruby-gems G /usr/local/bin
pkg plugins
pkg provides /usr/local/bin/zsh
pkg search cssc
pkg stats
pkg which /usr/local/bin/zsh
poudriere jail -l
poudriere ports -l
pstat -sh
pwait processus-id
python3 -m ensurepip --user
rcorder /etc/rc.d/* /usr/local/etc/rc.d/*
restic restore -r /media/da0s1/restic latest --target ~
restic restore -r /media/da0s1/restic latest --target ~ --include ~/racine/self
sade
seatd-launch hyprland
service -e
sockstat
sockstat -l4
ssh-copy-id -i ~/.ssh/id_rsa.pub tixu.local
ssh-keygen -t rsa -b 4096
sshfs=demonte ; fusermount -u ~/tremplin/sshfs
sshfs=laozu ; sshfs laozu.local:$HOME ~/tremplin/sshfs
sshfs=monte ; sshfs shari.local:$HOME ~/tremplin/sshfs
sshfs=quigonjinn ; sshfs quigonjinn.local:$HOME ~/tremplin/sshfs
sshfs=shari ; sshfs shari.local:$HOME ~/tremplin/sshfs
sshfs=tixu ; sshfs tixu.local:$HOME ~/tremplin/sshfs
sync=shari-auto ; unison remote $HOME ssh://user_name@shari.local//$HOME -ui text
sysctl -a G 'cpu.*temperature'
sysctl dev.cpu.0.freq=800
sysctl dev.cpu.0.freq_levels
sysctl net.wlan.devices
sysctl vfs.usermount
systat
umount ~/tremplin/usbdrive
usbconfig
vidcontrol -i mode
vidcontrol red # syscons, console virtuelle, root
vidfont # syscons, console virtuelle, root
vmstat
xfce4-keyboard-shortcuts
xfce4-settings-editor
zfs list
zfs snapshot -r zroot/ROOT/vanilla@tarballs
zpool iostat
zpool list
zpool status -v zroot
