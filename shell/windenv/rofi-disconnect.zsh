#! /usr/bin/env zsh

menu=(Non Peut-être Oui)

choix=$(print -l $menu | rofi -dmenu -p "Déconnexion ? " -i)

[ $choix = Oui ] || exit 0

winman=$(wmctrl -m | head -n 1 | cut -d ' ' -f 2)

if [ $winman = i3 ]
then
	i3-msg exit
elif [ $winman = bspwm ]
then
	bspwm-autostop.zsh &>>! ~/log/autostop.log
	bspc quit
elif [ $winman = herbstluftwm ]
then
	hlwm-autostop.zsh &>>! ~/log/autostop.log
	herbstclient quit
fi
