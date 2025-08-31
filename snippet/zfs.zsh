sudo gpart add -t freebsd-boot -s 512k -l boot ada0
sudo gpart add -t freebsd-zfs -a 1m -l root ada0 # used by zpool create ... gpt/root
sudo gpart bootcode -b /mnt/boot/pmbr -p /mnt/boot/gptzfsboot -i 1 ada0 # legacy bios ???
sudo gpart bootcode -p /mnt/boot/boot1.efi -i 1 ada0 # efi ???
touch /mnt/etc/fstab
sudo zfs create -o atime=on /zroot/var/mail
sudo zfs create -o canmount=noauto -o mountpoint=/ zroot/ROOT/default
sudo zfs create -o canmount=off -o mountpoint=none zroot/ROOT
sudo zfs create -o canmount=off zroot/usr
sudo zfs create -o canmount=off zroot/var
sudo zfs create -o exec=off /zroot/var/audit
sudo zfs create -o exec=off /zroot/var/crash
sudo zfs create -o exec=off /zroot/var/log
sudo zfs create -o mountpoint=/usr/local/poudriere zroot/poudriere
sudo zfs create -o setuid=off -o utf8only=off zroot/tmp
sudo zfs create -o setuid=off zroot/usr/ports
sudo zfs create -o setuid=off zroot/usr/src
sudo zfs create -o setuid=off zroot/var/tmp
sudo zfs create -V 4g -o org.freebsd:swap=on -o compression=zle -o dedup=off -o sync=disabled -o primarycache=metadata -o secondarycache=none zroot/swap
sudo zfs create cle-usb/compressed
sudo zfs create zroot/home # or zroot/usr/home
sudo zfs diff cle-usb/compressed@initial
sudo zfs list -rt all
sudo zfs mount zroot/ROOT/default
sudo zfs set compression=gzip cle-usb/compressed
sudo zfs snapshot cle-usb/compressed@initial
sudo zfs unmount cle-usb
sudo zfs unmount cle-usb/compressed
sudo zpool create -o altroot=/mnt -o compression=on -o atime=off -O mountpoint=/ -0 canmount=off zroot gpt/root # see gpart add ... -l root
sudo zpool create cle-usb /dev/da4
sudo zpool create zmirror /dev/da0 /dev/da1
sudo zpool set bootfs=zroot/ROOT/default zroot
sudo zpool set cachefile=/mnt/boot/zfs/zpool.cache zroot
sudo zpool resilver zroot
sudo zpool scrub -s zroot
sudo zpool scrub -w zroot
sudo zpool scrub zroot
sudo zpool upgrade -a
sudo zpool upgrade pool-name
zfs list
zfs snapshot -r zroot/ROOT/vanilla@tarballs
zpool iostat
zpool list
zpool status -v zroot
