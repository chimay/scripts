#!/usr/bin/env zsh

liste=()

while read element
do
	liste+=$element
done

numero=1
tagitem=()

for element in $liste
do
	tagitem+=($numero $element)
	(( numero += 1 ))
done

exec 3>&1
choix=$(dialog --menu "Liste" 0 0 0 $=tagitem 2>&1 1>&3)
exec 3>&-

code=$?

(( $code > 0)) && exit 1

echo $~liste[$choix]
