#!/usr/bin/env zsh

[ $# -gt 0 ] || {
	echo "Usage : $0 application"
	echo
	exit 0
}

application=$1

case $application in
	ladybird)
		pattern=/tmp/.mount_lady*
		;;
	waterfox)
		pattern=/tmp/.mount_water*
		;;
	floorp)
		pattern=/tmp/.mount_floor*
		;;
	mullvad-browser)
		pattern=/tmp/.mount_mullv*
		;;
	zen-browser)
		pattern=/tmp/.mount_zen*
		;;
	helium)
		pattern=
		umount /tmp/.mount_helium*
		;;
	sioyek)
		pattern=/tmp/.mount_sioyek*
		;;
	airclone)
		pattern=/tmp/.mount_airclo*
		;;
	*)
		echo application $application not supported
		exit 0
		;;
esac

echo umount $~pattern
echo
umount $~pattern
echo

echo rm -f $~pattern
echo
rm -rf $~pattern
echo
