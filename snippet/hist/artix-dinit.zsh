btrfs balance start --bg /
btrfs balance status /
btrfs filesystem defragment -r / # sudo
btrfs filesystem df /
btrfs filesystem mkswapfile --size 4g --uuid clear /swap/swapfile
btrfs filesystem usage / # sudo
btrfs send --proto 2 --compressed-data '/mnt/arch/snapshots/@var' | btrfs receive '/mnt/arch-v2/subvolumes/' # sudo
btrfs send /root_backup | btrfs receive /backup # sudo
btrfs subvolume create /path/to/subvolume # sudo
btrfs subvolume create /swap # sudo
btrfs subvolume list -p / # sudo
btrfs subvolume snapshot source dest # sudo
dinitctl enable sshd  # sudo
pacman -S artix-archlinux-support # sudo
swapon /swap/swapfile # sudo
