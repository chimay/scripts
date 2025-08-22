arcstat
cat update.json | vmadm update virtual-machine
imgadm avail
prstat -Z
sudo imgadm import os-image
sudo pkgin update
sudo pkgin upgrade
sudo vmadm create -f virtual-machine.json
sudo vmadm info virtual-machine-uuid
sudo vmadm reboot virtual-machine-uuid
sudo vmadm start virtual-machine-uuid
sudo vmadm stop virtual-machine-uuid
sudo vmadm update
vmadm console virtual-machine-uuid
vmadm list
zfs get compression
