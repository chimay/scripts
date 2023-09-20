#! /usr/bin/env zsh

#print -l $path

# Modi disponibles :
#
# drun

# exec rofi \
# 	-modi run,window,ssh,keys,combi \
# 	-combi-modi window,run \
# 	-show run \
# 	-sidebar-mode \
# 	-scroll-method 1 \
# 	-matching glob \
# 	-no-show-match \
# 	-lines 15 \
# 	-width 60 \
# 	-location 0 \
# 	-multi-select \
# 	-terminal lxterminal

exec rofi \
	-show combi \
	-mesg "Shift + Gauche ou Droite pour changer de rubrique" \
	-p "combi "
	-theme ~/racine/config/terminal/rofi/theme.rasi
