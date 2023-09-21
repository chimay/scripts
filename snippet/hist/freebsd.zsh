# boot0cfg -B ada0 # install boot0 sur le MBR
# boot0cfg -s 1 ada0 # définit la slice 1 par défaut
# boot0cfg -t 1200 ada0 # règle le timeout en ticks (~ 18e de seconde)
# bootx64.efi # à lancer dans le shell efi pour lancer l’installation si pas automatique
# sxhkd -m 1 # ???
/etc/rc.d/sysctl reload # doas
VBoxClient --display
VBoxClient-all
acpiconf -i 0
acpiconf -s 3 # sleep
adduser # doas
beadm create new-snapshot # doas
beadm destroy new-snapshot # doas
beadm list # doas
bectl list # doas
bsdconfig # doas
bsdinstall auto # doas
camcontrol devlist # cd, dvd, usb key
cap_mkdb /etc/login.conf # doas
chanson=local && mpc -f "%file%"
chflags -v noschg /usr/jails/yinyang.antra/var/empty
chpass user
cle=agent ; eval $(ssh-agent)
cle=liste ; ssh-add -l
cle=ssh-local ; ssh-add ~/racine/config/cmdline/ssh/$HOST/id_rsa
cp /boot/loader.efi /boot/efi/EFI/boot/bootx64.efi
demonte=cleusb ; umount /media/da0s1
devinfo -rv
ext4fuse /dev/da4s1 ~/tremplin/usbdrive
ezjail-admin create yinyang.antra 'lo1|127.0.1.1,fxp0|192.168.1.100' # doas
ezjail-admin install # doas
ezjail-admin start yinyang.antra # doas
ezjail-admin stop yinyang.antra # doas
find ~/photo -type f -links +1 L
find ~/photo -type f -printf '%n %p\n' | awk '$1 > 1 {$1="";print}'
find ~/photo -type f \! -links 1 L
fondecran=1 ; pkill fond-ecran.zsh ; sleep 1 ; fond-ecran.zsh 12 84 ~/graphix/list/wallpaper.gen >>! ~/log/fond-ecran.log &!
freebsd-update -r 13.0-RELEASE upgrade # doas
freebsd-update fetch # doas
freebsd-update install # doas
freebsd-version
gem install --user-install neovim
git clone https://git.freebsd.org/ports.git --branch main /usr/ports # doas
gitup ports # doas
gpart bootcode -b /boot/pmbr -p /boot/gptzfsboot -i 1 ada0 # legacy bios ???
gpart bootcode -p /boot/boot1.efi -i 1 ada0 # efi ???
gpart show
ifconfig wlan0 create wlandevice iwn0 # doas
ifconfig wlan0 list scan # doas
ifconfig wlan0 scan # doas
ifconfig wlan0 up # doas
jexec j-name /bin/sh # doas
kbdmap # console virtuelle, root
kldload coretemp # doas
kldload ext2fs # doas
kldload ipmi # doas
kldload vboxguest # doas
kldstat
ls -l `find ~/photo -type f -links +1` L
lsblk
make search name=xzgv L
mdconfig -a -t vnode -f swapfile -u 0 # doas
mdconfig -l -v # doas
mixer vol 70
mixertui
mkdir=run-media ; doas mkdir -p /run/media/user
monte=cleusb ; mount -t msdosfs /dev/da0s1 /media/da0s1
monte=cleusb ; udevil mount /dev/sdb1 /media/cleusb
monte=diskext-sdb1 ; udevil mount /dev/sdb1 /run/media/user/sdb1
monte=sdb1 ; udevil mount /dev/sdb1 /run/media/user/sdb1
mount_vboxvfs -w virtualbox-share /mnt # doas
mpliste=Detente ; droits-audio.zsh ; mpc --wait update ; mpc crop ; mpc load $mpliste ; mpc play
mpliste=Meditation ; droits-audio.zsh ; mpc --wait update ; mpc crop ; mpc load $mpliste ; mpc play
mpliste=Tout ; droits-audio.zsh ; mpc --wait update ; mpc crop ; mpc load $mpliste ; mpc play
networkmgr # doas
networkmgr &
nmcli dev wifi
passwd root
passwd toor
pciconf -clv
pciconf -lv
pciconf -lv | grep -A1 -B3 network
pfctl -d # doas
pgrep -lf vim
pip3 install --user --upgrade neovim
pip3 install --user --upgrade pip
pkg bootstrap # doas
pkg bootstrap -f # doas
pkg info -l devel/ruby-gems G /usr/local/bin
pkg install -r custom-repo some-package
pkg install lightdm lightdm-gtk-greeter # doas
pkg install linux-browser-installer # doas
pkg install networkmgr # doas
pkg search cssc
pkg update # doas
pkg upgrade # doas
portsnap extract # doas
portsnap fetch # doas
portsnap update # doas
pstat -sh
pw groupmod wheel -m user # doas
pw usermod user -G wheel,operator,video,audio # doas
pw usermod toor -u 0 # doas
python3 -m ensurepip --user
restic restore -r /media/da0s1/restic latest --target ~
restic restore -r /media/da0s1/restic latest --target ~ --include ~/racine/self
sade
service -e
service automount restart # doas
service automount start # doas
service automountd start # doas
service autounmountd start # doas
service avahi-daemon restart # doas
service dbus restart # doas
service dhclient restart fxp0 # doas
service ezjail restart
service netif restart
service virtual_oss enable # doas
shutdown -h now # doas
sockstat
ssh-copy-id -i ~/.ssh/id_rsa.pub tixu.local
ssh-keygen -t rsa -b 4096
sshfs=demonte ; fusermount -u ~/tremplin/sshfs
sshfs=laozu ; sshfs laozu.local:$HOME ~/tremplin/sshfs
sshfs=monte ; sshfs shari.local:$HOME ~/tremplin/sshfs
sshfs=quigonjinn ; sshfs quigonjinn.local:$HOME ~/tremplin/sshfs
sshfs=shari ; sshfs shari.local:$HOME ~/tremplin/sshfs
sshfs=tixu ; sshfs tixu.local:$HOME ~/tremplin/sshfs
swapinfo -h # doas
swapinfo -k # doas
swapon -aL # doas
swapon /dev/md0 # doas
sync=shari-auto ; unison remote $HOME ssh://user@shari.local//$HOME -ui text
sysctl -a G 'cpu.*temperature'
sysctl debug.acpi.suspend_bounce=1  # before testing suspend # doas
sysctl dev.cpu.0.freq=800
sysctl dev.cpu.0.freq_levels
sysctl dev.pcm.0.play.vchans=4 # doas
sysctl dev.pcm.0.rec.vchans=4 # doas
sysctl hw.snd.maxautovchans=4 # doas
sysctl net.wlan.devices
sysrc cloned_interfaces="lo1" # doas
sysrc ezjail_enable="YES" # doas
sysrc ifconfig_wlan0="WPA DHCP" # doas
sysrc powerd_enable=YES # doas
sysrc wlans_ath0="wlan0" # doas
systat
truncate -s 8G swapfile # doas
umount ~/tremplin/usbdrive
usbconfig
vidcontrol -i mode
vidcontrol red # syscons, console virtuelle, root
vidfont # syscons, console virtuelle, root
vmstat
zfs create cle-usb/compressed # doas
zfs diff cle-usb/compressed@initial # doas
zfs list
zfs list -rt all # doas
zfs set compression=gzip cle-usb/compressed # doas
zfs snapshot cle-usb/compressed@initial # doas
zfs unmount cle-usb # doas
zfs unmount cle-usb/compressed # doas
zpool create cle-usb /dev/da4 # doas
zpool list
zpool upgrade -a # doas
zpool upgrade pool-name # doas
