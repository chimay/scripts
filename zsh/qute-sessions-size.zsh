#!/usr/bin/env /bin/zsh

# vim: set filetype=zsh:

taille=${1:-17in}

#echo HOST = $HOST

cd ~/racine/dotdir/qutebrowser/$HOST/sessions

if [[ $taille = 17in ]]
then
	sed -i \
		'/geometry: !!binary/{n ; s/.*/    AdnQywACAAAAAACsAAAAIwAABbkAAANCAAAArQAAADsAAAW4AAADQQAAAAAAAAAABkA=/}' \
		*.yml
elif [[ $taille = 19in ]]
then
	sed -i \
		'/geometry: !!binary/{n ; s/.*/    AdnQywACAAAAAAEEAAAAIwAABowAAAOuAAABBQAAADsAAAaLAAADrQAAAAAAAAAAB4A=/}' \
		*.yml
fi
