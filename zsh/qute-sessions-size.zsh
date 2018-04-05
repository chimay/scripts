#!/usr/bin/env /bin/zsh

# vim: set filetype=zsh:

taille=${1:-17in}

echo Hote : $HOST
echo

cd ~/racine/dotdir/qutebrowser/$HOST/sessions

if [[ $taille = 17in ]]
then
	echo Taille : 17 pouces
	echo

	sed -i \
		'/geometry: !!binary/{n ; s/.*/    AdnQywACAAAAAACsAAAAIwAABbkAAANCAAAArQAAADsAAAW4AAADQQAAAAAAAAAABkA=/}' \
		*.yml
elif [[ $taille = 19in ]]
then
	echo Taille : 19 pouces
	echo

	sed -i \
		'/geometry: !!binary/{n ; s/.*/    AdnQywACAAAAAAEEAAAAIwAABowAAAOuAAABBQAAADsAAAaLAAADrQAAAAAAAAAAB4A=/}' \
		*.yml
fi
