#! /usr/bin/env zsh

arguments=($*)

echo "minuter.zsh $=arguments ..."
echo

minuter.zsh $=arguments \
	~/audio/sonnerie/ding/clochette.ogg \
	~/audio/sonnerie/ding/reception.ogg \
	~/audio/sonnerie/ding/clochette.ogg \
	~/audio/sonnerie/ding/reception.ogg
