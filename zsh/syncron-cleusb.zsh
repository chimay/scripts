#! /usr/bin/env zsh

setopt extended_glob

delai=${1:-60}

syncle=~/racine/syncron/cleusb

alias syncron='rsync --verbose --progress --stats --human-readable --itemize-changes \
	--log-file="$HOME/log/rsync.log" \
	--rsh=ssh \
	--recursive --delete-during \
	--owner --group --times --perms --links \
	--update'

cd ~/racine

syncron -R plain/**/*(.m-$delai) $syncle

syncron -R site/**/*~(*~|*.html|*.epub)(.m-$delai) $syncle

syncron -R shell/**/*(.m-$delai) $syncle

syncron -R config/cmdline/**/*(.m-$delai) $syncle
syncron -R config/edit/**/*(.m-$delai) $syncle
syncron -R config/webrowser/**/*(.m-$delai) $syncle
