#! /usr/bin/env zsh

# {{{ Zenity

choix=`\
	zenity --list --radiolist \
	--width=300 --height=300 \
	--text "Sortir" \
	--print-column=ALL \
	--column "Choix" --column "Action" \
	TRUE "Ne rien faire" \
	FALSE "Mettre en veille" \
	FALSE "Hiberner" \
	FALSE "Eteindre"
`

# }}}

sync

# Méthode basée sur systemctl {{{1

case $choix in

	"Mettre en veille")
		echo "systemctl suspend"
		systemctl suspend
		;;

	"Hiberner")
		echo "systemctl hibernate"
		#systemctl hibernate
		;;

	"Eteindre")
		echo "systemctl poweroff"
		systemctl poweroff
		;;

	*)
		echo "Aucun choix"
		;;
esac

# }}}1
