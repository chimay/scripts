pkg install brand/sparse
sttydefs -a ttya -i '115200 hupcl opost onlcr ofill' -f '115200'
sudo bootadm update-archive
sudo zfs create -o mountpoint=/zone rpool/zone
sudo zlogin firstzone
sudo zoneadm -z firstzone boot
sudo zoneadm -z firstzone install
sudo zonecfg -z firstzone
ttydefs -r ttya
