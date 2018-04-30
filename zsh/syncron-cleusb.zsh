#! /usr/bin/env zsh

# Documentation {{{1

# Option de rsync :
#
# -R = --relative : transmet les chemins complets à la destination

# Deux méthodes

# Méthode 1 {{{2

# cd ~/racine
#
# syncron -R dir/**/*(.m-$delai)

# }}}2

# Méthode 2 {{{2

# Noter le ./ au milieu du chemin source :
#
# syncron -R ~/racine/./dir/**/*(.m-$delai)

# }}}2

# }}}1

setopt extended_glob
setopt no_match
unsetopt null_glob

delai=${1:-90}

syncle=~/racine/syncron/cleusb

alias syncron='rsync --verbose --progress --human-readable --itemize-changes \
	--rsh=ssh \
	--recursive --delete-during \
	--owner --group --times --perms --links \
	--exclude-from=$HOME/racine/common/sync/rsync-exclude \
	--update'

cd ~/racine

echo
echo "============================================================"
echo "    Syncron cle usb $(date +'%A %d %B %Y %H:%M')"
echo "============================================================"
echo

echo
echo "syncron -R plain/**/*(.m-$delai) $syncle"
echo
syncron -R plain/**/*(.m-$delai) $syncle

echo
echo "syncron -R site/**/*~(*~|*.html|*.epub)(.m-$delai) $syncle"
echo
syncron -R site/**/*~(*~|*.html|*.epub)(.m-$delai) $syncle

echo
echo "syncron -R public/**/*~(*~|*.html|*.epub)(.m-$delai) $syncle"
echo
syncron -R public/**/*~(*~|*.html|*.epub)(.m-$delai) $syncle

echo
echo "syncron -R artisan/**/*(.m-$delai) $syncle"
echo
syncron -R artisan/**/*(.m-$delai) $syncle

echo
echo "syncron -R musica/**/*(.m-$delai) $syncle"
echo
syncron -R musica/**/*(.m-$delai) $syncle

echo
echo "syncron -R litera/**/*(.m-$delai) $syncle"
echo
syncron -R litera/**/*(.m-$delai) $syncle

echo
echo "syncron -R pictura/**/*(.m-$delai) $syncle"
echo
syncron -R pictura/**/*(.m-$delai) $syncle

echo
echo "syncron -R scien/**/*(.m-$delai) $syncle"
echo
syncron -R scien/**/*(.m-$delai) $syncle

echo
echo "syncron -R liber/**/*(.m-$delai) $syncle"
echo
syncron -R liber/**/*(.m-$delai) $syncle

echo
echo "syncron -R shell/**/*(.m-$delai) $syncle"
echo
syncron -R shell/**/*(.m-$delai) $syncle

echo
echo "syncron -R bin/**/*(.m-$delai) $syncle"
echo
syncron -R bin/**/*(.m-$delai) $syncle

echo
echo "syncron -R automat/**/*(.m-$delai) $syncle"
echo
syncron -R automat/**/*(.m-$delai) $syncle

echo
echo "syncron -R install/**/*(.m-$delai) $syncle"
echo
syncron -R install/**/*(.m-$delai) $syncle

echo
echo "syncron -R pack/bin/**/*(.m-$delai) $syncle"
echo
syncron -R pack/bin/**/*(.m-$delai) $syncle

echo
echo "syncron -R config/auto/**/*(.m-$delai) $syncle"
echo
syncron -R config/auto/**/*(.m-$delai) $syncle

echo
echo "syncron -R config/cmdline/**/*(.m-$delai) $syncle"
echo
syncron -R config/cmdline/**/*(.m-$delai) $syncle

echo
echo "syncron -R config/edit/**/*(.m-$delai) $syncle"
echo
syncron -R config/edit/**/*(.m-$delai) $syncle

echo
echo "syncron -R config/fileman/**/*(.m-$delai) $syncle"
echo
syncron -R config/fileman/**/*(.m-$delai) $syncle

echo
echo "syncron -R config/mail/**/*(.m-$delai) $syncle"
echo
syncron -R config/mail/**/*(.m-$delai) $syncle

echo
echo "syncron -R config/mime/**/*(.m-$delai) $syncle"
echo
syncron -R config/mime/**/*(.m-$delai) $syncle

echo
echo "syncron -R config/multimedia/**/*(.m-$delai) $syncle"
echo
syncron -R config/multimedia/**/*(.m-$delai) $syncle

echo
echo "syncron -R config/multiplex/**/*(.m-$delai) $syncle"
echo
syncron -R config/multiplex/**/*(.m-$delai) $syncle

echo
echo "syncron -R config/music/**/*(.m-$delai) $syncle"
echo
syncron -R config/music/**/*(.m-$delai) $syncle

echo
echo "syncron -R config/network/**/*(.m-$delai) $syncle"
echo
syncron -R config/network/**/*(.m-$delai) $syncle

echo
echo "syncron -R config/pack/**/*(.m-$delai) $syncle"
echo
syncron -R config/pack/**/*(.m-$delai) $syncle

echo
echo "syncron -R config/print/**/*(.m-$delai) $syncle"
echo
syncron -R config/print/**/*(.m-$delai) $syncle

echo
echo "syncron -R config/system/**/*(.m-$delai) $syncle"
echo
syncron -R config/system/**/*(.m-$delai) $syncle

echo
echo "syncron -R config/terminal/**/*(.m-$delai) $syncle"
echo
syncron -R config/terminal/**/*(.m-$delai) $syncle

echo
echo "syncron -R config/textmod/**/*(.m-$delai) $syncle"
echo
syncron -R config/textmod/**/*(.m-$delai) $syncle

echo
echo "syncron -R config/utils/**/*(.m-$delai) $syncle"
echo
syncron -R config/utils/**/*(.m-$delai) $syncle

echo
echo "syncron -R config/version/**/*(.m-$delai) $syncle"
echo
syncron -R config/version/**/*(.m-$delai) $syncle

echo
echo "syncron -R config/virtual/**/*(.m-$delai) $syncle"
echo
syncron -R config/virtual/**/*(.m-$delai) $syncle

echo
echo "syncron -R config/visu/**/*(.m-$delai) $syncle"
echo
syncron -R config/visu/**/*(.m-$delai) $syncle

echo
echo "syncron -R config/webrowser/**/*(.m-$delai) $syncle"
echo
syncron -R config/webrowser/**/*(.m-$delai) $syncle

echo
echo "syncron -R config/windenv/**/*(.m-$delai) $syncle"
echo
syncron -R config/windenv/**/*(.m-$delai) $syncle

echo
echo "syncron -R multics/**/*(.m-$delai) $syncle"
echo
syncron -R multics/**/*(.m-$delai) $syncle

echo
echo "syncron -R common/**/*(.m-$delai) $syncle"
echo
syncron -R common/**/*(.m-$delai) $syncle

echo
echo "syncron -R feder/**/*(.m-$delai) $syncle"
echo
syncron -R feder/**/*(.m-$delai) $syncle

echo
echo "syncron -R hub/**/*(.m-$delai) $syncle"
echo
syncron -R hub/**/*(.m-$delai) $syncle

echo
echo "syncron -R meta/**/*(.m-$delai) $syncle"
echo
syncron -R meta/**/*(.m-$delai) $syncle

echo
echo "syncron -R omni/**/*(.m-$delai) $syncle"
echo
syncron -R omni/**/*(.m-$delai) $syncle

echo
echo "syncron -R refer/**/*(.m-$delai) $syncle"
echo
syncron -R refer/**/*(.m-$delai) $syncle

echo
echo "syncron -R self/**/*(.m-$delai) $syncle"
echo
syncron -R self/**/*(.m-$delai) $syncle

echo
echo "syncron -R system/**/*(.m-$delai) $syncle"
echo
syncron -R system/**/*(.m-$delai) $syncle

echo
echo "syncron -R hist/**/*(.m-$delai) $syncle"
echo
syncron -R hist/**/*(.m-$delai) $syncle

echo
echo "syncron -R snippet/**/*(.m-$delai) $syncle"
echo
syncron -R snippet/**/*(.m-$delai) $syncle

echo
echo "syncron -R plugin/data/**/*(.m-$delai) $syncle"
echo
syncron -R plugin/data/**/*(.m-$delai) $syncle

echo
echo "syncron -R repo/**/*(.m-$delai) $syncle"
echo
syncron -R repo/**/*(.m-$delai) $syncle

echo
echo "syncron -R template/**/*(.m-$delai) $syncle"
echo
syncron -R template/**/*(.m-$delai) $syncle

echo
echo "syncron -R void/**/*(.m-$delai) $syncle"
echo
syncron -R void/**/*(.m-$delai) $syncle
