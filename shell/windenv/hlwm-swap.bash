#!/bin/bash
# Like hc's move command, but the moved window is replaced by a swap

# credit: https://github.com/everett1992/herbstluftwm/blob/master/swap

function hc() {
    herbstclient "$@"
}

function lock() {
 hc lock
}
function unlock() {
  hc unlock
}

direction=$1
follow=${2:-dont-follow}

echo direction : $direction
echo

case $direction in
	left)
		reverse=right
		;;
	right)
		reverse=left
		;;
	up)
		reverse=down
		;;
	down)
		reverse=up
		;;
	*)
		exit 1
esac

#lock
#trap unlock EXIT

prime_winid=$(hc attr clients.focus.winid)

echo prime id : $prime_winid
echo

# focus window to switch with
echo "hc focus $1"
echo
hc focus $1

if [ $? -ne 0 ]; then
	echo $?
	exit 1
fi

next_winid=$(hc attr clients.focus.winid)

echo next id  : $next_winid
echo

layout=$(hc dump)

echo $layout
echo

new_layout="$(echo "$layout" | sed -e "s/$prime_winid/SWAP_TOKEN/g; s/$next_winid/$prime_winid/g; s/SWAP_TOKEN/$next_winid/g")"

echo $new_layout
echo

hc load "$new_layout"

[ $follow = follow ] || hc focus $reverse

#unlock
