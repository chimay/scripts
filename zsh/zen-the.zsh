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

integer heures minutes secondes

heures=0
minutes=0
secondes=0

if [[ $sortie = ?*:?*:?* ]]
then
	temps=(${(s/:/)sortie})
	heures=$temps[1]
	minutes=$temps[2]
	secondes=$temps[3]

elif [[ $sortie = ?*:?*: ]]
then
	temps=(${(s/:/)sortie})
	heures=$temps[1]
	minutes=$temps[2]

elif [[ $sortie = ?*::?* ]]
then
	temps=(${(s/:/)sortie})
	heures=$temps[1]
	secondes=$temps[2]

elif [[ $sortie = ?*:: ]]
then
	temps=(${(s/:/)sortie})
	heures=$temps[1]

elif [[ $sortie = :?*:?* ]]
then
	temps=(${(s/:/)sortie})
	minutes=$temps[1]
	secondes=$temps[2]

elif [[ $sortie = :?*: ]]
then
	temps=(${(s/:/)sortie})
	minutes=$temps[1]

elif [[ $sortie = ::?* ]]
then
	temps=(${(s/:/)sortie})
	secondes=$temps[1]

elif [[ $sortie = :: ]]
then
	mate-terminal --hide-menubar --geometry=120x30+300+70 -x less +G ~/log/minuterie.log
	exit 0
fi

echo "the.zsh $heures:$minutes:$secondes"
echo

the.zsh $heures:$minutes:$secondes
