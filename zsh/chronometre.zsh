#! /usr/bin/env zsh

setopt extended_glob

echo Use Ctrl-C to quit
echo

seconde=0

while true
do
	sleep 1

	(( seconde += 1 ))

	echo -n '\t' $seconde

	(( seconde % 12 == 0 )) && echo
done
