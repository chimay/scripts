#!/usr/bin/env sh

if pgrep -af fluidsynth | grep -v "$0" > /dev/null
then
	echo fluidsynth is already running.
	exit 0
fi

flags='-a pulseaudio -m alsa_seq -p FluidSynth_G -r 48000'
sound=/usr/share/soundfonts/FluidR3_GM.sf2

echo "fluidsynth -is $flags $sound"
fluidsynth -is $flags $sound &
