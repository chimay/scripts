#! /usr/bin/env zsh

navigateur=${1:-vivaldi-stable}

surfraw -browser=$navigateur \
	$(surfraw -elvi | \
	awk -F'-' '{print $1}' | \
	sed '/:/d' | \
	awk '{$1=$1};1' | \
	rofi -kb-row-select "Tab" \
	-kb-row-tab "Control+space" \
	-dmenu \
	-mesg ">>> Tab = Autocomplete" \
	-i \
	-p "recherche "
)
