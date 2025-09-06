btrfs balance start --bg / # sudo
btrfs balance status / # sudo
btrfs filesystem defragment -r / # sudo
btrfs filesystem df / # sudo
btrfs filesystem mkswapfile --size 4g --uuid clear /swap/swapfile # sudo
btrfs filesystem usage / # sudo
btrfs property list -ts /.snapshots/1/snapshot
btrfs property set -ts /.snapshots/1/snapshot ro false # sudo
btrfs property set /swap/swapfile compression none
btrfs send --proto 2 --compressed-data '/mnt/arch/snapshots/@var' | btrfs receive '/mnt/arch-v2/subvolumes/' # sudo
btrfs send /root_backup | btrfs receive /backup # sudo
btrfs subvolume create /mnt/@ # sudo, / subvol
btrfs subvolume create /mnt/@home # sudo, home subvol
btrfs subvolume create /mnt/@snapshots # sudo, snapshots subvol
btrfs subvolume create /mnt/@swap # sudo
btrfs subvolume create /mnt/@var # sudo, var subvol
btrfs subvolume list -p / # sudo
btrfs subvolume snapshot /mnt/@snapshots/1/snapshot /mnt/@ # sudo
btrfs subvolume snapshot source dest # sudo
chattr +C /swap/swapfile
chmod 0600 /swap/swapfile
chmod a+rx /.snapshots # sudo
dd if=/dev/zero of=/swap/swapfile bs=1G count=8 status=progress
mkdir /mnt/.snapshots # sudo
mount -o noatime,compress=lzo,space_cache,subvol=@ /dev/sda3 /mnt # sudo
mount -o noatime,compress=lzo,space_cache,subvol=@home /dev/sda3 /mnt/home # sudo
mount -o noatime,compress=lzo,space_cache,subvol=@snapshots /dev/sda3 /mnt/.snapshots # sudo
mount -o noatime,compress=lzo,space_cache,subvol=@var /dev/sda3 /mnt/var # sudo
mount -o nodatacow,subvol=@swap /dev/sda3 /mnt/swap
mount /dev/sda1 /mnt/boot
pacman -S btrfs-progs grub-btrfs efibootmgr snapper snapper-gui # sudo
snapper -c root-fs create -c timeline --description after-install # sudo
snapper -c root-fs create-config / # sudo
snapper -c root-fs list # sudo
swapon /swap/swapfile
systemctl enable grub-btrfs.path # sudo
systemctl enable snapper-cleanup.timer # sudo
systemctl enable snapper-timeline.timer # sudo
systemctl start grub-btrfs.path # sudo
systemctl start snapper-cleanup.timer # sudo
systemctl start snapper-timeline.timer # sudo
truncate -s 0 /swap/swapfile
vim /mnt/@snapshots/*/info.xml # sudo
