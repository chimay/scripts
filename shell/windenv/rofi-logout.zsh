#! /usr/bin/env zsh

menu=(no "let me think" yes)

choix=$(print -l $menu | rofi -dmenu -p "Déconnexion ? " -i)

[ $choix = yes ] || exit 0

winman=$(wmctrl -m | head -n 1 | cut -d ' ' -f 2)

echo winman : $winman
echo

if [ $winman = "Hyprland" ]
then
	hypr-logout.zsh
elif [ $winman = herbstluftwm ]
then
	hlwm-autostop.zsh &>>! ~/log/autostop.log
	herbstclient quit
elif [ $winman = bspwm ]
then
	bspwm-autostop.zsh &>>! ~/log/autostop.log
	bspc quit
elif [ $winman = i3 ]
then
	i3-msg exit
fi
