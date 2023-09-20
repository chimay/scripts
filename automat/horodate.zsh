#! /usr/bin/env zsh

# vim: set filetype=zsh :

emulate -R zsh

setopt local_options

temps=$(date +" [=] %A %d %B %Y  (o) %H:%M  | %:z | ")

(( marge = 72 - ${#temps} ))

echo ""
echo "========================================================================"

(( milieu = 0.5 * marge ))

for (( i = 0 ; i < milieu ; i++ ))
do
	echo -n "="
done

echo -n $temps

for (( j = i + 1 ; j <= marge ; j++ ))
do
	echo -n "="
done

echo ""

echo "========================================================================"
echo ""
