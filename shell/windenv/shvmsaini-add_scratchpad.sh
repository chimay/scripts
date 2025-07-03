#! /bin/bash
# 
# Author: github.com/shvmsaini
# This script marks the current focused client to be used as "scratchpad", which in my understanding is a window which can be spawned anywhere on any tag.
# Supported Flags:
# --no-float : Makes window to not be in floating state if it already isn't.
# --no-sticky : Makes window to only appear in its current tag.
# First argument is Key and second is mode

file="$HOME/racine/config/windenv/herbstluftwm/scratchpad.txt"
icon=/usr/share/icons/Papirus/32x32/actions/bookmark-new.svg
hc=herbstclient
key="$1"
mode="$2"
floating=true
sticky=true

#todo: place back with same properties and same place

while [ $# -gt 2 ]; do
  case $1 in
    --no-float)
 		floating=false     	
      ;;
    --no-sticky)
     	sticky=false
      ;;
    *)
      echo "script usage: $(basename $0) [--no-float] [--no-sticky]" >&2
      exit 1
      ;;
  esac
  shift
done

id=$(cat $file | grep "$key" | cut -d'=' -f2)
id=$($hc get_attr clients.$id.winid)

if [ $? -eq 0 ]; then
	if [ $mode = "Remove" ]; then
		# Get Stored properties
		currTag=$(cat $file | grep "$key" | cut -d'=' -f5)
		isFloating=$(cat $file | grep "$key" | cut -d'=' -f4)
		isSticky=$(cat $file | grep "$key" | cut -d'=' -f3)

		# Remove from file
		sed -i "/$key/d" $file
		
		# Set back previous properties
		$hc set_attr clients.$id.floating $isFloating
		$hc set_attr clients.$id.sticky $isSticky
		$hc move $currTag
		
		notify-send -t 1500 "Unmarked"
		exit 0
	fi
	$hc set_attr clients."$id".minimized toggle
else
	# Remove any existing keys
	sed -i "/$key/d" $file
	notify-send -t 1500 "Marked"
	id=$($hc get_attr clients.focus.winid) 
	
	# Get Current Properties of the client
	isFloating=$($hc get_attr clients.$id.floating)
	currTag=$($hc get_attr clients.$id.tag)
	isSticky=$($hc get_attr clients.$id.sticky)

	# Set supplied/default properties
	$hc set_attr clients.$id.sticky $sticky
	$hc set_attr clients.$id.floating $floating
	
	# Store 
	echo $key=$id=$isSticky=$isFloating=$currTag >> $file
fi
