#! /usr/bin/env zsh

exec rofi \
	-modi window,run \
	-show window \
	-mesg "Shift + Gauche ou Droite pour changer de rubrique" \
	-p "rofi : "
