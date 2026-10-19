#!/usr/bin/env zsh

export PATH=$PATH:~/script

numarg=$#

[ $numarg -eq 0 ] && {
	command=${0##*/}
	echo "Usage : $command <time_change> <images-directory>"
	echo
	exit 0
}

time_change=$1
directory=$2

echo "cd $directory"
echo
cd $directory

images=( $(print -l **/*(.) | shuf ) )

num_images=$#images

counter=1

while true
do
	if [ $counter -gt $num_images ]
	then
		images=( $(print -l **/*(.) | shuf ) )
		num_images=$#images
		counter=1
	fi
	current=$images[$counter]
	echo counter : $counter
	echo current : $current
	echo
	(( counter += 1 ))
	if [ -n "$WAYLAND_DISPLAY" ]
	then
		awww img --resize fit $current
	elif [ -n "$DISPLAY" ]
	then
		echo ""
		echo
		xfce-change-wall-all-workspaces.bash $current
		# echo "feh --bg-max --no-fehbg $current"
		# echo
		# feh --bg-max --no-fehbg $current
		# echo "xwallpaper --zoom  $current"
		# echo
		# xwallpaper --zoom  $current
	fi
	sleep $time_change
done
