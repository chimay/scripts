#!/bin/bash
# Originally by https://github.com/windelicato/

follower() {
while [[ $(pgrep -cx euclid_mover) = 1 ]] ; do
	bspc config pointer_follows_focus false
done
}

trap 'follower' INT TERM QUIT EXIT

size=${2:-'20'}
dir=$1

transplanter() {
	bspc node ${dir} -p south && bspc node -n ${dir}
}

northplanter() {
	bspc node north -p north && bspc node -n north
}

rootplanter() {
	bspc node @/ -p ${dir} && bspc node -n @/ || bspc node -s next.local && bspc node -n @/
	bspc node @/ -p cancel
}

bspc config pointer_follows_focus true
# Find current window mode
is_floating() {
bspc query -T -n | grep -q '"state":"floating"'
}
# If the window is floating, move it
if is_floating; then
#only parse input if window is floating,tiled windows accept input as is
        case "$dir" in
  		west) switch="-x"
  		sign="-"
        	;;
  		east) switch="-x"
         	sign="+"
       		;;
  		north) switch="-y"
         	sign="-"
        	;;
  		*) switch="-y"
     		sign="+"
     		;;
 		esac
 xdo move ${switch} ${sign}${size}

# Otherwise, window is tiled: switch with window in given direction
else
	 if [[ $(bspc query -N -n .local.\!floating | wc -l) != 2 ]]; then
	 case "$dir" in
  		north) northplanter || rootplanter
        	;;
  		*) transplanter || rootplanter
     		;;
 	 esac
 	 else
 	 case "$dir" in
  		east) bspc node -s east || bspc node @/ -R 90
        	;;
        west) bspc node -s west || bspc node @/ -R 270
        	;;
        south) bspc node -s south || bspc node @/ -R 90
        	;;
  		*) bspc node -s north || bspc node @/ -R 270
     		;;
     esac
     fi
fi
