#!/usr/bin/env sh

application=$1
action=${2:-none}

ramdir=/tmp/dot-cache/$application

[ -e "$ramdir" ] || mkdir -p "$ramdir"

[ -d "$ramdir" ] || {
	echo "$ramdir exists and is not a directory"
	echo
}

cd ~/.cache || {
	echo "home cache dir does not exist"
	exit 1
}

[ -L "$application" ] || {
	mv "$application" "$application.bak"
	ln -s "$ramdir" .
}

$application

sleep 3

[ "$action" = delete ] && {
	rm -rf "$ramdir"
}

sleep 2

echo "unmount-appimage.sh $application"
echo
unmount-appimage.sh "$application"
