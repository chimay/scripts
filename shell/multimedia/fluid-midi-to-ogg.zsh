#!/usr/bin/env zsh

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
	echo
	echo "fluidsynth  -nli -r 44100 -o synth.cpu-cores=2 -T oga -F $ogg $sound $midi"
	echo
	fluidsynth  -nli -r 44100 -o synth.cpu-cores=2 -T oga -F $ogg $sound $midi
done

# }}}1
