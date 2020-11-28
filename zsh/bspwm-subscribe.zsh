#!/usr/bin/env /bin/zsh

# vim: set filetype=zsh:

presel=0

bspc subscribe node_add node_presel | \
	while read ligne
	do
		date +"%H:%M:%S %d %m %Y"
		echo $ligne | grep node_presel | grep -v cancel &>/dev/null &&
			{
				echo Presel on
				presel=1
			}
		echo $ligne | grep node_presel | grep cancel &>/dev/null &&
			{
				echo Presel off
				echo Skipping next node added
			}
		if echo $ligne | grep node_add
		then
			if (( presel == 1 ))
			then
				presel=0
			else
				echo Going to big
				bspc node -f $(echo $ligne | awk '{print $5}')
				bspc node -s biggest.local
			fi
		fi
	done &
