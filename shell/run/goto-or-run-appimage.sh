#! /usr/bin/env sh

application=$1
shift

echo application : $application
echo

xdotool search --class "$application" windowactivate && exit 0

"$application" "$@" >> ~/log/"$application".log 2>&1

sleep 5

# ---- ensure appimage fs is unmounted

case $application in
	 floorp)
		echo "umount /tmp/.mount_floor*"
		echo
		umount /tmp/.mount_floor*
		;;
	 zen-browser)
		echo "umount /tmp/.mount_zen-br*"
		echo
		umount /tmp/.mount_zen-br*
		;;
	 mullvad-browser)
		echo "umount /tmp/.mount_mullv*"
		echo
		umount /tmp/.mount_mullv*
		;;
esac
