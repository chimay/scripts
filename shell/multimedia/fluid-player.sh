#!/usr/bin/env sh

# rlwrap solution {{{1

rlwrap \
	--always-readline --history-no-dupes 2 \
	-H ~/racine/hist/rlwrap/fluid.history \
	-f ~/racine/hist/rlwrap/fluid.comp \
	fluidsynth -a alsa -m alsa_seq /usr/share/soundfonts/FluidR3_GM.sf2 "$@"

# pipe solution, doesnt work {{{1

# pipe=~/racine/run/pipe/fluidsynth
# fluidsynth -a alsa -m alsa_seq /usr/share/soundfonts/FluidR3_GM.sf2 "$@" < $pipe &
# printf 'fluid > '
# while read -r line
# do
# 	case $line in
# 		q)
# 			echo quit > $pipe
# 			;;
# 		p)
# 			echo player_stop > $pipe
# 			;;
# 		c)
# 			echo player_cont > $pipe
# 			;;
# 		j)
# 			echo 'player_seek +3000' > $pipe
# 			;;
# 		k)
# 			echo 'player_seek -3000' > $pipe
# 			;;
# 		l)
# 			echo 'player_seek +9000' > $pipe
# 			;;
# 		h)
# 			echo 'player_seek -9000' > $pipe
# 			;;
# 	esac
# 	printf 'fluid > '
# done

# server solution, doesnt work {{{1

# fluidsynth \
# 	--audio-driver=alsa \
# 	--midi-driver=alsa_seq \
# 	--server \
# 	-o shell.port=9988 \
# 	/usr/share/soundfonts/FluidR3_GM.sf2 \
# 	"$@" &
