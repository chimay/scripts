avahi-browse --all --ignore-local --resolve --terminate
avahi-discover
avahi-resolve-host-name taijitu.local
avahi-resolve-host-name taijitu.local
cpu=ls-modules ; ls /usr/lib/modules/$(uname -r)/kernel/drivers/cpufreq/
cpu=max-freq ; sudo cpupower frequency-set -u 1300MHz
cpu=powersave ; sudo cpupower frequency-set -g $cpu
cpu_epb=12 ; sudo cpupower set -b $cpu_epb
cpu_epb=12 ; sudo echo $cpu_epb | sudo tee /sys/devices/system/cpu/cpu*/power/energy_perf_bias
dbus=list ; busctl list
sudo dinitctl enable avahi-daemon
sudo dinitctl enable sshd
sudo dinitctl restart dinit-user-spawn
sudo pacman -S artix-archlinux-support
sudo pacman -S avahi avahi-dinit nss-mdns
sudo pacman -S pacman-contrib
sudo pacman -S xfce4-whiskermenu-plugin
sudo swapon /swap/swapfile
sudo update-ca-trust
sudo yay pacman-static
xdg-settings get default-web-browser
zramctl ; echo ; swapon -s
