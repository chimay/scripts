#!/usr/bin/env /bin/sh

# vim: set filetype=sh:

if [ $(bspc query -N -n focused.tiled.local) = $(bspc query -N -n biggest.tiled.local) ]
then
	bspc node -s smallest.tiled.local
else
	bspc node -s biggest.tiled.local
fi

bspc node -f biggest.local
