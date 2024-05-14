#!/usr/bin/env sh

xdotool search --class freetube windowactivate && exit 0

freetube
sleep 5
#cp -f ~/.config/FreeTube/*.db ~/racine/feder/central/freetube/database
cp -f ~/racine/config/social/freetube/*.db ~/racine/feder/central/freetube/database
