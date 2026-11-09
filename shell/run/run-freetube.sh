#!/usr/bin/env sh

xdotool search --class Freetube windowactivate && exit 0

{
	date
	echo
	freetube
	echo
} >> ~/log/freetube.log 2>&1

sleep 5

#cp -f ~/.config/FreeTube/*.db ~/racine/feder/central/freetube/database
cp -f ~/racine/config/social/freetube/*.db ~/racine/feder/central/freetube/database

sleep 1

echo "unmount-appimage.sh freetube"
echo
unmount-appimage.sh freetube
