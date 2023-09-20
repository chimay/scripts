#! /usr/bin/env zsh

setopt extended_glob
setopt nocaseglob

# {{{ Arguments

(( resLongueur = 2048 ))
(( resHauteur = 2048 ))

resolutions=()
autres=()

while true
do
	case $1 in
		[0-9]##)
			resolutions=($resolutions $1)
			shift
			;;
		?*)
			autres=($autres $1)
			shift
			;;
		*)
			break
			;;
	esac
done

(( $#resolutions == 1 )) && {

	resLongueur=$resolutions[1]
	resHauteur=$resolutions[1]
}

(( $#resolutions == 2 )) && {

	resLongueur=$resolutions[1]
	resHauteur=$resolutions[2]
}

echo "Resolution : $resLongueur x $resHauteur"

# }}}

# {{{ Compression

for argument in $autres
do
	if [[ -f $argument ]]
	then
		echo "mogrify -verbose -resize \"${resLongueur}x${resHauteur}>\" $argument"

		mogrify -verbose -resize "${resLongueur}x${resHauteur}>" $argument

	elif [[ -d $argument ]]
	then
		for fichier in ${argument}/**/*.(png|jpg|jpeg|gif)
		do
			echo "mogrify -verbose -resize \"${resLongueur}x${resHauteur}>\" $fichier"

			mogrify -verbose -resize "${resLongueur}x${resHauteur}>" $fichier
		done
	fi
done

# }}}

# {{{ Idées à creuser

#mogrify -verbose -resize "${resLongueur}x${resHauteur}>" -quality 75 $argument

# ----

#find . -name "*.jpg" -exec convert "{}" -resize "2048x2048" -quality 90% "{}_sm" \;
#rename 's/.jpg_sm/_sm.jpg/' *_sm

# }}}
