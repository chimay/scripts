#! /usr/bin/env zsh

arguments=($*)

echo "minuterie.zsh $=arguments ..."
echo

minuterie.zsh $=arguments \
	~/audio/Sonnerie/ding/clochette.ogg \
	~/audio/Sonnerie/ding/reception.ogg \
	~/audio/Sonnerie/ding/clochette.ogg \
	~/audio/Sonnerie/ding/reception.ogg
