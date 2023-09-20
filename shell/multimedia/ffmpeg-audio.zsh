#! /usr/bin/env zsh

# vim: set conceallevel=0 :

format=$1

shift

# {{{ Arguments

if [[ $format = "ogg" ]]
then
	qualite=7

elif [[ $format = "mp3" ]]
then
	qualite=0
fi

bitrate=256k

while true
do
	case $1 in
		q*=?*)
			qualite=${1#*\=}
			shift
			;;
		b*=?*)
			bitrate=${1#*\=}
			shift
			;;
		*)
			break
			;;
	esac
done

echo "Qualité : $qualite"
echo
echo "Bitrate : $bitrate"
echo
echo '------------------------------------'
echo

# }}}

echo

if false
then
	:

# {{{ WAV

elif [ $format = "wav" ]
then

	for entree in "$@"
	do
		#sortie=$(echo $entree | sed "s/\..*/.wav/")

		sortie=${entree%.*}.$format

		echo "$entree --> $sortie"
		echo
		echo "ffmpeg -i \"$entree\" -threads 2 -vn -ar 44100 \"$sortie\""
		echo

		ffmpeg -i "$entree" -threads 2 -vn -ar 44100 "$sortie"
	done

# }}}

# {{{ FLAC

elif [ $format = "flac" ]
then

	for entree in "$@"
	do
		#sortie=$(echo $entree | sed "s/\..*/.flac/")

		sortie=${entree%.*}.$format

		echo "$entree --> $sortie"
		echo
		echo "ffmpeg -i \"$entree\" -threads 2 -vn -codec:a flac -ac 2 \"$sortie\""
		echo

		ffmpeg -i "$entree" -threads 2 -vn -codec:a flac -ac 2 "$sortie"
	done

# }}}

# {{{ Ogg vorbis

elif [ $format = "ogg" ]
then

	# +------------------------+
	# |   -1 <= Qualité <= 10  |
	# +------------------------+

	for entree in "$@"
	do
		#sortie=$(echo $entree | sed "s/\..*/.ogg/")

		sortie=${entree%.*}.$format

		echo "$entree --> $sortie"
		echo
		echo "ffmpeg -i \"$entree\" -threads 2 -vn -codec:a libvorbis -q:a $qualite -ac 2 \"$sortie\""
		echo

		ffmpeg -i "$entree" -threads 2 -vn -codec:a libvorbis -q:a $qualite -ac 2 "$sortie"
	done

# }}}

# {{{ MP3

elif [ $format = "mp3" ]
then

	# +------------------------+
	# |   9 => Qualité => 0   |
	# +------------------------+

	for entree in "$@"
	do
		#sortie=$(echo $entree | sed "s/\..*/.mp3/")

		sortie=${entree%.*}.$format

		echo "$entree --> $sortie"
		echo
		echo "ffmpeg -i \"$entree\" -threads 2 -vn -codec:a libmp3lame -b:a $bitrate -q:a $qualite -ac 2 -ar 44100 \"$sortie\""
		echo

		ffmpeg -i "$entree" -threads 2 -vn -codec:a libmp3lame -b:a $bitrate -q:a $qualite -ac 2 -ar 44100 "$sortie"
	done

# }}}

fi
