#sysconfig create-profile -o zone1-profile.xml
beadm activate  indiana-backup
beadm create indiana-backup
beadm create indiana-updated
beadm destroy  indiana-marche-pas
beadm list
beadm mount indiana-updated /mnt
cat "192.168.1.1" > /etc/defaultrouter
cp /etc/nsswitch.dns /etc/nsswitch.conf
sudo sharemgr start -P smb zfs
sudo zfs set sharesmb=on tank
dladm show-link
dladm show-phys
echo "SHUTDOWN:::profile to shutdown:help=shutdown.html" >> /etc/security/prof_attr
format
ifconfig iprb0 dhcp start
ifconfig iprb0 plump up
installgrub -m /boot/grub/stage1 /boot/grub/stage2 /dev/rdsk/c3t1d0s0
ipadm create-addr -T dhcp iprb0
ipadm create-addr -T static -a 192.168.0.25/24 bgc0/v4
ipadm create-if bgc0
ipadm create-if iprb0
ipadm show-addr
nwam-manager
nwamadm enable home
nwamadm enable office
nwamadm list
nwamcfg create ncp home
nwamcfg create ncp office
pfexec pkg install pkg:/editor/gnu-emacs/gnu-emacs-no-x11@29.1-2023.0.0.1
pkg -R /mnt update
pkg update
profiles
reboot -- -r
rmformat -l
roleadd shutdown ; passwd shutdown ; usermod -R shutdown <user>
rolemod -P SHUTDOWN shutdown
roles
sudo bootmenu set-menu timeout 30
sudo dladm create-vnic -l iprb0 vnic1
sudo init 0
sudo init 6
sudo route -p add default 192.168.0.1
sudo svcadm disable network/physical:default
sudo svcadm enable nwam
sudo touch /etc/dhcp.iprb0
sudo touch /etc/hostname.iprb0
sudo usermod -P "Software Installation" <username>
svccfg ...
svcs -a
svcs apache22
zfs create -o mountpoint /zones rpool/zones
zlogin -C zone1
zoneadm -z zone1 boot
zoneadm -z zone1 halt
zoneadm -z zone1 install -c /root/zone1-profile.xml
zoneadm -z zone2 -c /root/zone2-profile.xml zone1
zoneadm list -cv
zonecfg -z zone1
zonestat 2
zpool attach -f rpool1 c3t0d0s0 c3t1d0s0
