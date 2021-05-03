#! /usr/bin/env zsh

# Minuter with default arguments

arguments=($*)

echo "minuter.zsh $=arguments ..."
echo

minuter.zsh $=arguments \
	~/audio/sonnerie/ding/clochette.ogg \
	~/audio/sonnerie/ding/reception.ogg \
	~/audio/sonnerie/ding/clochette.ogg \
	~/audio/sonnerie/ding/reception.ogg
