avahi-browse --all --ignore-local --resolve --terminate
avahi-discover
avahi-resolve-host-name taijitu.local
avahi-resolve-host-name taijitu.local
cpu=powersave ; sudo cpupower frequency-set -g $cpu
dbus=list ; busctl list
sudo dinitctl enable avahi-daemon
sudo dinitctl enable sshd
sudo pacman -S artix-archlinux-support
sudo pacman -S avahi avahi-dinit nss-mdns
sudo pacman -S pacman-contrib
sudo pacman -S xfce4-whiskermenu-plugin
sudo swapon /swap/swapfile
sudo update-ca-trust
sudo yay pacman-static
xdg-settings get default-web-browser
zramctl ; echo ; swapon -s
