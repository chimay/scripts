#!/usr/bin/env sh

[ $# -gt 0 ] || {
	echo "Usage : $0 application"
	echo
	exit 0
}

application=$1

# ---- ensure appimage fs is unmounted

case $application in
	 ladybird)
		echo "umount /tmp/.mount_lady*"
		echo
		umount /tmp/.mount_lady*
		;;
	 waterfox)
		echo "umount /tmp/.mount_water*"
		echo
		umount /tmp/.mount_water*
		;;
	 floorp)
		echo "umount /tmp/.mount_floor*"
		echo
		umount /tmp/.mount_floor*
		;;
	 mullvad-browser)
		echo "umount /tmp/.mount_mullv*"
		echo
		umount /tmp/.mount_mullv*
		;;
	 zen-browser)
		echo "umount /tmp/.mount_zen*"
		echo
		umount /tmp/.mount_zen*
		;;
	 helium)
		echo "umount /tmp/.mount_helium*"
		echo
		umount /tmp/.mount_helium*
		;;
	 airclone)
		echo "umount /tmp/.mount_airclo*"
		echo
		umount /tmp/.mount_airclo*
		;;
esac
