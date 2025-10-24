# @bak 01. ---- First time
# @bak 02. sudo zfs snapshot -r zroot@bak
# @bak 03. sudo gpart modify -i 2 -t freebsd-zfs da0 # gpt partition table
# @bak 04. sudo gpart modify -i 2 -t freebsd da0 # dos mbr partition table
# @bak 05. sudo zpool create -o altroot=/mnt/edrive -O compression=zstd -O atime=off edrive da0s2
# @bak 06. sudo zfs send -R zroot@bak | sudo zfs receive -vF edrive
# @bak 07. ---- Incremental
# @bak 08. sudo zfs rename -r zroot@bak{,-old}
# @bak 09. sudo zfs snapshot -r zroot@bak
# @bak 10. sudo zpool import -R /mnt/edrive edrive
# @bak 11. sudo zfs send -Ri zroot@bak-old zroot@bak | sudo zfs receive -vF edrive
# @bak 12. sudo zfs destroy -r zroot@bak-old
# @bak 13. sudo zfs umount edrive
# @bak 14. sudo zpool export edrive
# backup 1. zfs snapshot -r zroot@backup
# backup 2. zfs destroy zroot/usr/home/me/vbox@backup
# backup 3. zfs send -R --skip-missing zroot@backup > /backupdrive/filename # or send / receive
# backup 4. zfs destroy -r zroot@backup
# restore 1. mkdir /tmp/myroot
# restore 2. # nvd0p4 is my zfs partition
# restore 3. zpool create -d -o altroot=/tmp/myroot zroot nvd0p4
# restore 4. mkdir /tmp/mydata
# restore 5. # Backups were done to zdata1 pool on an external drive, mount it
# restore 6. zpool import -fR /tmp/mydata zdata1
# restore 7. # Restore all saved pools
# restore 8. cat /tmp/mydata/zdata1/filename | zfs recv -vF zroot
# restore 9. # Clean up
# zfs upgrade 1. sudo zpool upgrade
# zfs upgrade 2. sudo zpool upgrade zroot
# zfs upgrade 3. see freebsd.sh efi loader
cd /etc/mail ; sudo make aliases
gpart backup laptop-disk | gpart restore -F usb-disk
root@source:~# zfs send sourcepool/dataset | ssh target zfs receive targetpool/dataset
root@target:~# ssh source zfs send sourcepool/dataset | zfs receive targetpool/dataset
ssh host1 zfs send tank/foo@snapshot | zfs receive othertank/foo
sudo gpart add -t freebsd-boot -s 512k -l boot ada0
sudo gpart add -t freebsd-zfs -a 1m -l root ada0 # used by zpool create ... gpt/root
sudo gpart bootcode -b /mnt/boot/pmbr -p /mnt/boot/gptzfsboot -i 1 ada0 # legacy bios ???
sudo gpart bootcode -p /mnt/boot/boot1.efi -i 1 ada0 # efi ???
sudo gpart create -s gpt ada0
sudo gpart modify -i 1 -t freebsd da0 # dos mbr partition table
sudo gpart modify -i 1 -t freebsd-zfs da0 # gpt partition table
sudo kldload zfs
sudo zfs create -V 4g -o org.freebsd:swap=on -o compression=zle -o dedup=off -o sync=disabled -o primarycache=metadata -o secondarycache=none zroot/swap
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
sudo zfs create cle-usb/compressed
sudo zfs create zroot/home # or zroot/usr/home
sudo zfs diff cle-usb/compressed@initial
sudo zfs list -rt all
sudo zfs mount diskextpool
sudo zfs mount zroot/ROOT/default
sudo zfs send -Ri zroot@backup-2025-08-29 zroot@backup | sudo zfs receive -vF diskextpool
sudo zfs set atime=off zroot
sudo zfs set compression=gzip cle-usb/compressed
sudo zfs set compression=lz4 zroot
sudo zfs set mountpoint=/home zroot/home
sudo zfs set mountpoint=/myspecialfolder mypool
sudo zfs set mountpoint=/tmp zroot/tmp
sudo zfs set mountpoint=/usr zroot/usr
sudo zfs set mountpoint=legacy zroot
sudo zfs snapshot cle-usb/compressed@initial
sudo zfs umount -a
sudo zfs unmount cle-usb
sudo zfs unmount cle-usb/compressed
sudo zpool create -fm /mnt zroot /dev/gpt/data0
sudo zpool create -o altroot=/mnt -O compression=on -O atime=off -O mountpoint=/ -0 canmount=off zroot gpt/root # see gpart add ... -l root
sudo zpool create cle-usb /dev/da4
sudo zpool create zmirror /dev/da0 /dev/da1
sudo zpool get bootfs zroot
sudo zpool import
sudo zpool resilver zroot
sudo zpool scrub -s zroot
sudo zpool scrub -w zroot
sudo zpool scrub zroot
sudo zpool set bootfs=zroot zroot
sudo zpool set bootfs=zroot/ROOT/default zroot
sudo zpool set cachefile=/mnt/boot/zfs/zpool.cache zroot
sudo zpool upgrade -a
sudo zpool upgrade pool-name
touch /mnt/etc/fstab
touch /mnt/etc/resolv.conf
zdb -bDDD tank
zfs bookmark istorage/storage@week27 week27-bookmark
zfs destroy -r istorage/storage@previous_backup # get rid of the previous snapshot
zfs destroy istorage/storage@week27
zfs get -r mountpoint mypool
zfs list
zfs list -o name,mountpoint,mounted
zfs list -ro canmount,mounted,mountpoint,name
zfs list -rt snapshot zpool
zfs list diskextpool
zfs rename -r istorage/storage@backup istorage/storage@previous_backup # rename the "old" snapshot
zfs send -R istorage/storage@week25 | zfs receive -vF backup_hdd
zfs send -RI istorage/storage@week27 | zfs receive -v backup_hdd # incremental replication
zfs send -Ri istorage/storage@previous_backup istorage/storage@backup | zfs receive -v backup_hdd # incremental replication
zfs send -i week25 istorage/storage@week26 | zfs recv backup_hdd/storage
zfs send istorage/storage@week25 | zfs recv backup_hdd/storage
zfs send tank/foo@snapshot | ssh host2 zfs receive othertank/foo
zfs send zroot/desktop@backup > /backup-desktop.zfs
zfs snapshot -r zroot/desktop@backup
zfs snapshot istorage/storage@backup # take a new snapshot
zfs snapshot zroot/desktop@backup
zfs-send -R laptop-pool-snapshot | zfs-receive -vF new-pool
zfs-snapshot -r laptop-pool
zpool checkpoint --discard myzpool
zpool checkpoint myzpool
zpool export zdata1
zpool get -p allocated,size tank
zpool get all zroot
zpool get capacity tank
zpool import -- rewind-to-checkpoint myzpool
zpool import --read-only=on --rewind-to-checkpoint myzpool
zpool iostat
zpool list
zpool list -v
zpool set bootfs=zroot/ROOT/default zroot
zpool status -v zroot
zpool upgrade -v
