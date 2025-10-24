# bootcfg 1. boot0cfg -B ada0 # install boot0 sur le MBR
# bootcfg 2. boot0cfg -s 1 ada0 # définit la slice 1 par défaut
# bootcfg 3. boot0cfg -t 1200 ada0 # règle le timeout en ticks (~ 18e de seconde)
# ext2 1. kldload ext2fs
# ext2 2. mount -t ext2fs <device> <mount_point>
# linux compat 1. ls -l /compat/linux/
# linux compat 2. sudo service linux start
# linux compat 3. sudo sysrc linux_enable="YES"
# linux compat 4. sudo pkg install debootstrap
# linux compat 5. sudo debootstrap jammy /compat/ubuntu
# loop mount 0. dd if=/dev/zero of=partfile.dd bs=1M count=1100
# loop mount 1. mdconfig -l
# loop mount 2. mdconfig -a -t vnode -f partfile.dd -u 7
# loop mount 3. bsdlabel -w -B md7 auto
# loop mount 4. newfs -m 0 md7a
# loop mount 5. mount /dev/md7a /media
# loop mount 6. mount -t <fs_type> /dev/md7a <your_mountpoint>
# loop mount 7. umount /media
# loop mount 8. mdconfig -d -u 7
# loop mount 9. rm partfile.dd
# uefi 1. bootx64.efi # à lancer dans le shell efi pour lancer l’installation si pas automatique
# uefi loader 1. download minimal image (or boot the iso / img you downloaded) and create a boot usb stick
# uefi loader 2. boot from usb stick and go to to the emergency shell (or just boot single user).
# uefi loader 3. mount -t msdos /dev/da0pX /mnt pX is the ESP (where da0 is your root disk)
# uefi loader 4. cp /boot/boot1.efi /mnt/efi/boot/bootx86.efi
# uefi loader 5. cp /boot/loader.efi /mnt/efi/freebsd/loader.efi
# uefi loader 6. reboot
# uefi loader 7. dont do this from main disc : sudo gpart bootcode -p /mnt/boot/boot1.efi -i 1 ada0 # efi
# zram similar 1. mdconfig -a -t malloc -o compress -o reserve -s 50m -u 7
# zram similar 2. swapon /dev/md7
VBoxClient --display
VBoxClient-all
acpiconf -i 0
acpiconf -s 3 # sleep
bectl list
bsdinfo
camcontrol devlist # cd, dvd, usb key
chanson=local && mpc -f "%file%"
chpass user
chsh -s /usr/local/bin/zsh
cle=agent ; eval $(ssh-agent)
cle=liste ; ssh-add -l
cle=ssh-local ; ssh-add ~/racine/config/cmdline/ssh/$HOST/id_rsa
dbus-launch waybar
demonte=cleusb ; umount /media/da0s1
devinfo -rv
dmesg
dmesg | grep CPU:
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
kbdmap # console virtuelle, root
kldstat
kldstat -v
ls -l `find ~/photo -type f -links +1` L
ls /boot/kernel | grep -v kernel
ls /rescue
ls /usr/freebsd-dist # on the live cd
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
netstat -nr
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
restic snapshots -r /media/da0s1/restic -c
sade
seatd-launch hyprland
service -e
sockstat
sockstat -4 -l
sockstat -l4
ssh-copy-id -i ~/.ssh/id_rsa.pub tixu.local
ssh-keygen -t rsa -b 4096
sshfs=demonte ; fusermount -u ~/tremplin/sshfs
sshfs=laozu ; sshfs laozu.local:$HOME ~/tremplin/sshfs
sshfs=monte ; sshfs shari.local:$HOME ~/tremplin/sshfs
sshfs=quigonjinn ; sshfs quigonjinn.local:$HOME ~/tremplin/sshfs
sshfs=shari ; sshfs shari.local:$HOME ~/tremplin/sshfs
sshfs=tixu ; sshfs tixu.local:$HOME ~/tremplin/sshfs
sudo -s
sudo /etc/rc.d/sysctl reload
sudo adduser
sudo beadm create new-snapshot
sudo beadm destroy old-snapshot
sudo beadm list
sudo bectl activate vanilla
sudo bectl mount vanilla /mnt
sudo bsdconfig
sudo bsdinstall auto
sudo bsdinstall netconfig
sudo cap_mkdb /etc/login.conf
sudo cd /usr/ports/multimedia/vlc && make install-missing-packages
sudo chmod 0600 /usr/local/etc/ssl/keys
sudo chmod 0600 /usr/local/etc/ssl/keys/poudriere.key
sudo chroot /compat/ubuntu /bin/bash
sudo cp /boot/loader.efi /boot/efi/EFI/boot/bootx64.efi
sudo cp /boot/loader.efi /boot/efi/EFI/freebsd/loader.efi
sudo debootstrap focal /compat/ubuntu
sudo echo 'FreeBSD: { url: "pkg+http://pkg.FreeBSD.org/${ABI}/latest" }' > /usr/local/etc/pkg/repos/FreeBSD.conf
sudo freebsd-update -r 13.0-RELEASE upgrade
sudo freebsd-update fetch
sudo freebsd-update install
sudo git clone https://git.freebsd.org/ports.git --branch main /usr/ports
sudo gitup ports
sudo gpart bootcode -b /mnt/boot/pmbr -p /mnt/boot/gptzfsboot -i 1 ada0 # legacy bios ???
sudo ifconfig wlan0 create wlandevice iwn0
sudo ifconfig wlan0 list scan
sudo ifconfig wlan0 scan
sudo ifconfig wlan0 up
sudo jexec j-name /bin/sh
sudo jexec tower df -h
sudo kldload coretemp
sudo kldload ext2fs
sudo kldload ipmi
sudo kldload vboxguest
sudo mdconfig -a -t vnode -f swapfile -u 0
sudo mdconfig -l -v
sudo mkdir -p /usr/local/etc/pkg/repos
sudo mkdir -p /usr/local/etc/ssl/{certs,keys}
sudo mount_msdosfs /dev/ada0p1 /boot/efi
sudo mount_msdosfs /dev/da0s1 /media
sudo mount_vboxvfs -w virtualbox-share /mnt
sudo networkmgr
sudo ntpdate -v -b in.pool.ntp.org
sudo ntpq -pn
sudo openssl genrsa -out /usr/local/etc/ssl/keys/poudriere.key 4096
sudo openssl rsa -in /usr/local/etc/ssl/keys/poudriere.key -pubout -out /usr/local/etc/ssl/certs/poudriere.cert
sudo pfctl -T show -t jails
sudo pfctl -d
sudo pfctl -e
sudo pfctl -f /etc/pf.conf
sudo pfctl -s nat
sudo pfctl -s rules
sudo pfctl -s states
sudo pfctl -sr
sudo pfctl -v -nf /etc/pf.conf
sudo pkg bootstrap
sudo pkg bootstrap -f
sudo pkg install -r custom-repo some-package
sudo pkg install -y pkg-provides pkg-rmleaf
sudo pkg install -y poudriere nginx memcached portmaster groff
sudo pkg install -y vim
sudo pkg install avahi-app nss_mdns
sudo pkg install debootstrap
sudo pkg install lightdm lightdm-gtk-greeter
sudo pkg install linux-browser-installer
sudo pkg install networkmgr
sudo pkg install xorg xf86-video-intel
sudo pkg lock -l
sudo pkg provides -u
sudo pkg update
sudo pkg update -f
sudo pkg upgrade
sudo pkg-static upgrade -f
sudo portsnap extract
sudo portsnap fetch
sudo portsnap update
sudo poudriere bulk -j 13-2-R-amd64 -f /usr/local/etc/poudriere.d/liste-de-paquets -p HEAD
sudo poudriere jail -c -j 13-2-R-amd64 -v 13.2-RELEASE
sudo poudriere jail -u -j 13-2-R-amd64
sudo poudriere options -c -j 13-2-R-amd64 -f /usr/local/etc/poudriere.d/liste-de-paquets
sudo poudriere ports -c -m git+https -B main -p HEAD
sudo poudriere ports -u
sudo pw groupmod audio -m user_name
sudo pw groupmod operator -m user_name
sudo pw groupmod video -m user_name
sudo pw groupmod wheel -m user_name
sudo pw usermod toor -u 0
sudo pw usermod user_name -G wheel,operator,video,audio
sudo service automount restart
sudo service automount start
sudo service automountd start
sudo service autounmountd start
sudo service avahi-daemon enable
sudo service avahi-daemon restart
sudo service dbus enable
sudo service dbus onerestart
sudo service dbus onestart
sudo service dbus restart
sudo service dbus start
sudo service devd restart
sudo service devfs restart
sudo service dhclient restart fxp0
sudo service netif restart
sudo service nginx enable  #doas
sudo service pf enable
sudo service pf start
sudo service pflog enable
sudo service pflog start
sudo service routing restart
sudo service virtual_oss enable
sudo shutdown -h now
sudo swapinfo -h
sudo swapinfo -k
sudo swapon -aL
sudo swapon /dev/md0
sudo sysctl debug.acpi.suspend_bounce=1  # before testing suspend
sudo sysctl dev.cpu.0.freq=800
sudo sysctl dev.pcm.0.play.vchans=4
sudo sysctl dev.pcm.0.rec.vchans=4
sudo sysctl hw.snd.maxautovchans=4
sudo sysctl net.inet.ip.forwarding=1
sudo sysctl vfs.usermount=1
sudo sysrc gateway_enable="YES"
sudo sysrc ifconfig_wlan0="WPA DHCP"
sudo sysrc keymap="us.kbd"
sudo sysrc powerd_enable=YES
sudo sysrc wlans_ath0="wlan0"
sudo truncate -s 8G swapfile
sudo usbconfig
sudoedit /etc/devfs.conf
sxhkd -m 1 # why ?
sync=shari-auto ; unison remote $HOME ssh://user_name@shari.local//$HOME -ui text
synth just-build audio/fluidsynth
synth status
sysctl -a | grep 'cpu.*temperature'
sysctl dev.cpu.0.freq
sysctl dev.cpu.0.freq_levels
sysctl dev.cpu.0.temperature
sysctl net.wlan.devices
sysctl vfs.usermount
systat
tar -x -C /mnt -f /usr/freebsd-dist/base.txz # on the live cd
tar -x -C /mnt -f /usr/freebsd-dist/kernel.txz # on the live cd
tar -xzpf -C /mnt -f /usr/freebsd-dist/base.txz # on the live cd
tar -xzpf -C /mnt -f /usr/freebsd-dist/kernel.txz # on the live cd
umount ~/tremplin/usbdrive
vidcontrol -i mode
vidcontrol red # syscons, console virtuelle, root
vidfont # syscons, console virtuelle, root
vmstat
xfce4-keyboard-shortcuts
xfce4-settings-editor
