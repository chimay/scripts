#!/usr/bin/env bash

# credit : www.passwordstore.org

shopt -s nullglob globstar

typeit=0
if [[ $1 == "--type" ]]; then
	typeit=1
	shift
fi

if [[ -n $WAYLAND_DISPLAY ]]; then
	dmenu=dmenu-wl
	xdotool="ydotool type --file -"
elif [[ -n $DISPLAY ]]; then
	#dmenu=dmenu
	dmenu=(dmenu -p 'pass : ' -b -l 35 -nb black -nf '#5b3c11' -sb '#5b3c11' -sf black)
	xdotool="xdotool type --clearmodifiers --file -"
else
	echo "Error: No Wayland or X11 display detected" >&2
	exit 1
fi

prefix=${PASSWORD_STORE_DIR-~/.password-store}
password_files=( "$prefix"/**/*.gpg )
password_files=( "${password_files[@]#"$prefix"/}" )
password_files=( "${password_files[@]%.gpg}" )

password=$(printf '%s\n' "${password_files[@]}" | "${dmenu[@]}" "$@")

[[ -n $password ]] || exit

if [[ $typeit -eq 0 ]]; then
	pass show -c "$password" 2>/dev/null
else
	pass show "$password" | { IFS= read -r pass; printf %s "$pass"; } | $xdotool
fi
