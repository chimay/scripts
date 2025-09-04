#!/usr/bin/env zsh

setopt extended_glob

# Initialisation {{{1

local chaud=75
local tres_chaud=80

local temps=10

local volume=100

# Functions {{{1

cpu-save () {
	# userspace has a low frequency range
	# see ~/.config/cpupower_gui/cpg-userspace.profile
	which cpupower-gui >& /dev/null && cpupower-gui profile userspace
}

player () {
	local fu_volume=$1
	local fu_fichier=$2
	[[ $fu_fichier[1] != / ]] && {
		fu_fichier=~/audio/bell/$fu_fichier
	}
	mpv-socket.bash replace $fu_fichier
	mpv-socket.bash volume $fu_volume
}

# Aide {{{1

[ $# -eq 0 ] && {
	echo Usage : ${0##*/} +chaud ++tres_chaud -temps volume
	echo
	echo "Par défaut :"
	echo
	echo Chaud : $chaud
	echo Très chaud : $tres_chaud
	echo Temps : $temps
	echo Volume : $volume
	exit
}

[ $# -gt 0 ] && [ $1 = help -o $1 = -h -o $1 = --help ] && {
	echo Usage : ${0##*/} +chaud ++tres_chaud -temps volume
	echo
	echo "Par défaut :"
	echo
	echo Chaud : $chaud
	echo Très chaud : $tres_chaud
	echo Temps : $temps
	echo Volume : $volume
	exit
}

# Arguments {{{1

while true
do
	case $1 in
		+[0-9]##)
			chaud=${1#+}
			shift
			;;
		++[0-9]##)
			tres_chaud=${1#++}
			shift
			;;
		-[0-9]##)
			temps=${1#-}
			shift
			;;
		[0-9]##)
			volume=$1
			shift
			;;
		?*)
			shift
			;;
		*)
			break
			;;
	esac
done

# Affichage {{{1

print Chaud : $chaud
print
print Très chaud : $tres_chaud
print
print Temps : $temps
print
print Volume : $volume
print

# Boucle {{{1

while true
do
	echo "== $(date +%T) =="
	echo

# 	senseurs=($(sensors | \
# 		grep -E '(temp|Core)[^(]+°C' | \
# 		sed 's/(.*)//' | \
# 		sed 's/°C//' | \
# 		sed 's/+//' | \
# 		sed 's/^temp[0-9]:\s\+//' | \
# 		sed 's/^Core [0-9]:\s\+//' \
# 	))

	senseurs=($(sensors | \
		grep -E 'Core[^(]+°C' | \
		sed 's/(.*)//' | \
		sed 's/°C//' | \
		sed 's/+//' | \
		sed 's/^temp[0-9]:\s\+//' | \
		sed 's/^Core [0-9]:\s\+//' \
	))

	#print -l $=senseurs
	#print

	maximum=0
	for elt in $senseurs
	do
		(( elt > maximum )) && maximum=$elt
	done

	echo maximum temperature : $maximum
	echo

	(( maximum >= tres_chaud )) && {
		cpu-save
		echo "player $volume ~/audio/bell/notification/cpu-tres-chaud.ogg"
		echo
		player $volume ~/audio/bell/notification/cpu-tres-chaud.ogg
		sleep 3
		continue
	}

	(( maximum >= chaud )) && {
		cpu-save
		echo "player $volume ~/audio/bell/notification/cpu-chaud.ogg"
		echo
		player $volume ~/audio/bell/notification/cpu-chaud.ogg
		sleep 3
		continue
	}

	sleep $temps
done
