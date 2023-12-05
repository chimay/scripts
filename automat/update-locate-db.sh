#!/bin/sh

DB_DIR=${1:-"$HOME/racine/index/filesys/locate"}

RACINE=$HOME/racine

updatedb -v -l 0 -U ~/racine -o "$DB_DIR/racine.db" \
	-n ".git .hg .bzr _darcs" \
	-e "
	$RACINE/archive
	$RACINE/local/share/astronvim
	$RACINE/local/share/lazyvim
	$RACINE/local/share/lunarvim
	$RACINE/local/share/lvim
	$RACINE/local/share/nvchad
	$RACINE/local/share/nvim-kickstarter
	$RACINE/pack/aged
	$RACINE/papier
	$RACINE/plugin/manager
	$RACINE/system/conf
	$RACINE/source
	$RACINE/test
	$RACINE/trash
	$RACINE/varia
	"

updatedb -v -l 0 -U ~/graphix -o "$DB_DIR"/graphix.db
updatedb -v -l 0 -U ~/audio -o "$DB_DIR"/audio.db
updatedb -v -l 0 -U ~/photo -o "$DB_DIR"/photo.db

updatedb -v -l 0 -U ~/.config -o "$DB_DIR"/dotconfig.db
updatedb -v -l 0 -U ~/.local -o "$DB_DIR"/dotlocal.db

updatedb -v -l 0 -U /usr/local -o "$DB_DIR"/usr-local.db
updatedb -v -l 0 -U /var/lib/pacman/local -o "$DB_DIR"/pacman-lib.db
