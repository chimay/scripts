#! /usr/bin/env zsh

# Minuter with default arguments

arguments=($*)

echo "minuter.zsh $=arguments ..."
echo

minuter.zsh $=arguments \
	~/audio/bell/ding/clochette.ogg \
	~/audio/bell/ding/reception.ogg \
	~/audio/bell/ding/clochette.ogg \
	~/audio/bell/ding/reception.ogg
