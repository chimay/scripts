cd /usr/local/share/bastille
jls
less /usr/local/bastille/jails/temple/rdr.conf
sudo sysrc bastille_list="temple tower"
sudoedit  /usr/local/bastille/jails/temple/jail.conf
sudo bastille bootstrap 13.2-RELEASE update
sudo bastille cmd ALL ps aux
sudo bastille cmd temple sockstat -4
sudo bastille console tower
sudo bastille create -B tower-dhcp 14.0-RELEASE 0.0.0.0 bridge0
sudo bastille create temple 14.3-RELEASE 192.168.1.250/24
sudo bastille create tower 13.2-RELEASE 192.168.1.250 wlan0
sudo bastille edit temple rdr.conf
sudo bastille list
sudo bastille list release
sudo bastille rdr temple clear
sudo bastille rdr temple list
sudo bastille rdr temple tcp 2001 22
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
sudo sysrc cloned_interfaces+=lo1
sudo sysrc ifconfig_lo1_name="bastille0"
sudo vim /usr/local/etc/bastille/bastille.conf
