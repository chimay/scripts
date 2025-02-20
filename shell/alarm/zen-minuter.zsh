#!/usr/bin/env zsh

export PATH=$PATH:~/racine/shell/alarm

alias psgrep="ps auxww | grep -v grep | grep --color=never"

output=$(\
	zenity \
	--title "Infusion" \
	--forms --separator ":" \
	--add-entry "Hours" \
	--add-entry "Minutes" \
	--add-entry "Seconds" \
	--add-entry "Volume" \
)

(( $? != 0 )) && exit 1

echo output : $output
echo length output : $#output
echo

if [[ $output = :: ]]
then
	urxvtc -geometry 120x30+300+70 -e less +G ~/log/minuters.log
	exit 0
fi

duration=${output%:*}
volume=${output//*:}
echo duration : $duration
echo volume : $volume

echo "ding-dong.zsh volume=$volume $duration"
echo

ding-dong.zsh volume=$volume $duration
