#!/usr/bin/env /bin/zsh

# vim: set filetype=zsh:

# Variables {{{1

#sound=~/racine/musica/soundfont/Unison.sf2
#sound=/usr/share/soundfonts/FluidR3_GM.sf2
sound=/usr/share/soundfonts/freepats-general-midi.sf2

# }}}1

# {{{ Arguments

lilydir=lilypond

argumen=()

while true
do
	case $1 in
		-d)
			shift
			lilydir=$1
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

# }}}

# Aide {{{1

[ $#argumen -eq 0 ] && {
	echo Usage : $0 '[-d lily-dest-dir] file(s)'
	exit 0
}

# }}}1

for score in $=argumen
do
	musedir=${score%/*}

	echo "cd $musedir"

	cd $musedir

	score=${score#$PWD/}

	# musescore dir

	pdf=${score%.*}.pdf

	[ ! -f $pdf -o $score -nt $pdf ] && {
		echo
		echo "musescore -o $pdf $score"
		echo
		musescore -o $pdf $score
	}

	midi=${score%.*}.midi

	[ ! -f $midi -o $score -nt $midi ] && {
		echo
		echo "musescore -o $midi $score"
		echo
		musescore -o $midi $score
	}

	ogg=${score%.*}.ogg

	[ ! -f $ogg -o $score -nt $ogg ] && {
		echo
		echo "musescore -o $ogg $score"
		echo
		musescore -o $ogg $score
	}

	# music xml bridge

	xml=$lilydir/${score%.*}.mxl

	[ ! -f $xml -o $score -nt $xml ] && {
		echo
		echo "musescore -o $xml $score"
		echo
		musescore -o $xml $score
	}

	# lilypond dir

	echo
	echo "cd $lilydir"

	cd $lilydir

	lily=${xml%.mxl}.ly

	[ ! -f $lily -o $xml -nt $lily ] && {
		echo
		echo "musicxml2ly -m $xml"
		echo
		musicxml2ly -m $xml
	}

	rm -f *.ly~

	pdf=${lily%.ly}.pdf
	midi=${lily%.ly}.midi

	[ ! -f $pdf -o $lily -nt $pdf -o ! -f $midi -o $lily -nt $midi ] && {
		echo
		echo "lilypond $lily"
		echo
		lilypond $lily
	}

	ogg_fluid=${lily%.ly}-fluid.ogg

	[ ! -f $ogg_fluid -o $midi -nt $ogg_fluid ] && {
		echo
		echo "fluidsynth  -nli -r 48000 -o synth.cpu-cores=2 -T oga -F $ogg_fluid $sound $midi"
		echo
		fluidsynth  -nli -r 48000 -o synth.cpu-cores=2 -T oga -F $ogg_fluid $sound $midi
	}

	ogg_timidity=${lily%.ly}-timidity.ogg

	[ ! -f $ogg_timidity -o $midi -nt $ogg_timidity ] && {
		echo
		echo "timidity -Ov -o $ogg_timidity $midi"
		echo
		timidity -Ov -o $ogg_timidity $midi
	}

	# back do musescore

	echo
	echo "cd -"

	cd -
done
