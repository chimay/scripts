#!/usr/bin/env zsh

# does not work

# Variables {{{1

sound=/usr/share/soundfonts/FluidR3_GM.sf2
#sound=/usr/share/soundfonts/freepats-general-midi.sf2
#sound=~/racine/musica/soundfont/Unison.sf2

argumen=($@)

# Aide {{{1

[ $#argumen -eq 0 ] && {
	echo Usage : $0 ' file(s)'
	echo
	echo Convert midi files to ogg
	exit 0
}

# Boucle {{{1

for midi in $=argumen
do
	ogg=${midi%.midi}.ogg
	echo
	echo "fluidsynth -a alsa -nli -r 44100 -o synth.cpu-cores=2 -T raw -F - $sound $midi | lame -q 0 -b 128 - - > $mpthree"
	echo
	fluidsynth -a alsa -nli -r 44100 -o synth.cpu-cores=2 -T raw -F - $sound $midi | lame -q 0 -b 128 - - > $mpthree
done
