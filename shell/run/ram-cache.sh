#!/usr/bin/env sh

application=$1
action=${2:-none}

ramdir=/tmp/dot-cache/$application
cachedir=$application

case $application in
	ladybird)
		cachedir=Ladybird
		;;
	zen-browser)
		cachedir=zen
		;;
esac

[ -e "$ramdir" ] || mkdir -p "$ramdir"

[ -d "$ramdir" ] || {
	echo "$ramdir exists and is not a directory"
	echo
}

cd ~/.cache || {
	echo "home cache dir does not exist"
	exit 1
}

[ -L "$cachedir" ] || {
	[ -e "$cachedir" ] && mv "$cachedir" "$cachedir.bak"
	ln -s "$ramdir" "$cachedir"
}

$application

sleep 5

[ "$action" = delete ] && {
	rm -rf "$ramdir"
}

echo "unmount-appimage.zsh $application"
echo
unmount-appimage.zsh "$application"
