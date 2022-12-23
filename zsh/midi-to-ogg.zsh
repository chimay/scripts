#!/usr/bin/env /bin/zsh

# vim: set filetype=zsh:

# Variables {{{1

sound=/usr/share/soundfonts/FluidR3_GM.sf2
#sound=/usr/share/soundfonts/freepats-general-midi.sf2
#sound=~/racine/musica/soundfont/Unison.sf2

# }}}1

argumen=($@)

# Aide {{{1

[ $#argumen -eq 0 ] && {
	echo Usage : $0 ' file(s)'
	echo
	echo Convert midi files to ogg
	exit 0
}

# }}}1

# Boucle {{{1

for midi in $=argumen
do
	ogg=${midi%.midi}.ogg
	[ ! -f $ogg -o $midi -nt $ogg ] && {
		echo
		echo "fluidsynth  -nli -r 48000 -o synth.cpu-cores=2 -T oga -F $ogg $sound $midi"
		echo
		fluidsynth  -nli -r 48000 -o synth.cpu-cores=2 -T oga -F $ogg $sound $midi

		#echo
		#echo "timidity -Ov -o $ogg $midi"
		#echo
		#timidity -Ov -o $ogg $midi
	}
done

# }}}1
