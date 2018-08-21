#!/usr/bin/env /bin/zsh

export PATH=$PATH:~/racine/shell/alarm

alias psgrep="ps auxww | grep -v grep | grep --color=never"

sortie=$(\
	zenity \
		--title "Infusion" \
		--forms --separator ":" \
		--add-entry "Heures" \
		--add-entry "Minutes" \
		--add-entry "Secondes" \
	)

(( $? != 0 )) && exit 1

echo Sortie : $sortie
echo Longueur sortie : $#sortie
echo

if [[ $sortie = :: ]]
then
	urxvtc -geometry 120x30+300+70 -e less +G ~/log/minuterie.log
	exit 0
fi

echo "the.zsh $sortie"
echo

the.zsh $sortie
