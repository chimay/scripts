# bridge 1. sudo sysrc cloned_interfaces+="bridge0"
# bridge 2. sudo sysrc ifconfig_bridge0="inet 192.168.0.1 netmask 255.255.255.0"
# bridge 3. sudo sysrc gateway_enable="yes"
# quickstart 1. sudo pkg install vm-bhyve grub2-bhyve bhyve-firmware
# quickstart 2. sudo zfs create zroot/bhyve-vms
# quickstart 3. sudo sysrc vm_enable="YES"
# quickstart 4. sudo sysrc vm_dir="zfs:zroot/bhyve-vms"
# quickstart 5. sudo kldload vmm
# quickstart 6. sudo vm init
# quickstart 7. sudo cp /usr/local/share/examples/vm-bhyve/* /zroot/bhyve-vms/.templates/
# quickstart 8. sudo vm set console=tmux
# quickstart 9. sudo vm switch create -t manual -b bridge0 public
sudo vm switch info
sudo kldstat -m vmm -v
sudo kldstat -qm vmm.ko
