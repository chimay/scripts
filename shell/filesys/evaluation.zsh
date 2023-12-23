#!/usr/bin/env zsh

emulate -R zsh
setopt local_options
setopt warn_create_global
setopt null_glob
zmodload zsh/regex

evaluation='NONE'
argumen=()

while true
do
	case $1 in
		[0-9a-zA-Z])
			evaluation=$1
			shift
			;;
		?*)
			argumen+=$1
			shift
			;;
		*)
			break
			;;
	esac
done

# Minuscules ?
#evaluation=${evaluation:l}

# Majuscules ?
evaluation=${evaluation:u}

for oldname in $argumen
do
	directory=${oldname%/?*}
	file=${oldname##?*/}
	[[ $directory = $oldname ]] && directory=.
	if [[ $file = [0-9a-zA-Z]-* ]]
	then
		corename=${file#?-}
	else
		corename=$file
	fi
	if [[ $evaluation != 'NONE' ]]
	then
		newname=${evaluation}-${corename}
	else
		newname=$corename
	fi
	echo directory  : $directory
	echo file       : $file
	echo corename      : $corename
	echo evaluation : $evaluation
	echo
	if [[ -e $directory/$file && $file != $newname ]]
	then
		echo "mv $file $newname"
		echo
		mv $directory/$file $directory/$newname
	else
		for tentative in $directory/?-${corename} $directory/$corename
		do
			essai=${tentative##?*/}
			if [[ -e $directory/$essai && $essai != $newname ]]
			then
				echo "mv $essai $newname"
				echo
				mv $directory/$essai $directory/$newname
				break
			fi
		done
	fi
done
