#sysconfig create-profile -o zone1-profile.xml
beadm activate  indiana-backup
beadm create indiana-backup
beadm create indiana-updated
beadm destroy  indiana-marche-pas
beadm list
beadm mount indiana-updated /mnt
cat "192.168.1.1" > /etc/defaultrouter
dladm create-vnic -l iprb0 vnic1
dladm show-link
dladm show-phys
ifconfig iprb0 dhcp start
ifconfig iprb0 plump up
ipadm create-addr -T dhcp iprb0
ipadm create-if iprb0
ipadm show-addr
nwam-manager
nwamadm enable home
nwamadm enable office
nwamadm list
nwamcfg create ncp home
nwamcfg create ncp office
pkg -R /mnt update
pkg update
reboot -- -r
rmformat -l
svcadm disable network/physical:default
svcadm enable nwam
svccfg ...
svcs -a
svcs apache22
touch /etc/dhcp.iprb0
touch /etc/hostname.iprb0
zfs create -o mountpoint /zones rpool/zones
zlogin -C zone1
zoneadm -z zone1 boot
zoneadm -z zone1 halt
zoneadm -z zone1 install -c /root/zone1-profile.xml
zoneadm -z zone2 -c /root/zone2-profile.xml zone1
zoneadm list -cv
zonecfg -z zone1
zonestat 2
