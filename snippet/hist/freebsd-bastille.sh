# ubuntu 00. sudo pkg install -y debootstrap
# ubuntu 01. sudo bastille create -E ubuntu
# ubuntu 02. sudo vim /boot/loader.conf
# ubuntu 03. sudo sysrc linux_enable=YES
# ubuntu 04. sudo reboot
# ubuntu 05. sudo debootstrap --foreign --arch=amd64 --no-check-gpg jammy /usr/local/bastille/jails/ubuntu/root
# ubuntu 06. sudo mkdir /usr/local/bastille/jails/ubuntu/home
# ubuntu 07. sudo bastille edit ubuntu fstab # nullfs for home, dev, proc, ...
# ubuntu 08. sudo bastille edit ubuntu jail.conf
# ubuntu 09. sudo bastille start ubuntu
# ubuntu 10. sudo jexec ubuntu /bin/bash
# ubuntu 11. 	dpkg --force-depends -i /var/cache/apt/archives/*.deb
# ubuntu 12. sudo bastille console ubuntu
# ubuntu 13. 	TERM=xterm apt update && apt upgrade
# ubuntu 14. 	apt-get install -y sysvinit-core
# ubuntu 15. 	apt install update-manager-core
# ubuntu 16. 	do-release-upgrade
# ubuntu 17. 	do-release-upgrade -d
cd /usr/local/share/bastille
jls
less /usr/local/bastille/jails/temple/rdr.conf
sudo bastille bootstrap 13.2-RELEASE update
sudo bastille cmd ALL ps aux
sudo bastille cmd temple sockstat -4
sudo bastille console tower
sudo bastille create -B tower-dhcp 14.0-RELEASE 0.0.0.0 bridge0
sudo bastille create temple 14.3-RELEASE 192.168.1.250/24
sudo bastille create tower 13.2-RELEASE 192.168.1.250 wlan0
sudo bastille destroy debian
sudo bastille edit temple rdr.conf
sudo bastille edit ubuntu fstab
sudo bastille list
sudo bastille list release
sudo bastille rdr temple clear
sudo bastille rdr temple list
sudo bastille rdr temple tcp 2001 22
sudo bastille rename ubuntu bionic
sudo bastille service temple sshd start
sudo bastille start tower
sudo bastille stop tower
sudo bastille sysrc temple sshd_enable=YES
sudo bastille update 13.2-RELEASE
sudo bastille verify 13.2-RELEASE
sudo pkg install -y bastille
sudo service bastille enable
sudo service netif cloneup
sudo sysrc bastille_enable=YES
sudo sysrc bastille_list="temple tower"
sudo sysrc cloned_interfaces+=lo1
sudo sysrc ifconfig_lo1_name="bastille0"
sudo vim /usr/local/etc/bastille/bastille.conf
sudoedit  /usr/local/bastille/jails/temple/jail.conf
ls /usr/local/share/debootstrap/scripts
