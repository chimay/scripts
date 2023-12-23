#!/usr/bin/env zsh

emulate -R zsh
setopt local_options
setopt warn_create_global
setopt null_glob
zmodload zsh/regex

path+=(~/racine/shell/filesys)

evaluation='NONE'
root=${1:-~/graphix}

evaluation=$(\
	zenity \
	--title "Wallpaper" \
	--forms \
	--add-entry "evaluation" \
)

# Minuscules ?
#evaluation=${evaluation:l}

# Majuscules ?
evaluation=${evaluation:u}

name=`sed -n '/.*:.*:.*/p' ~/log/wallpaper.log | tail -n 1 `
name=${name##*:}
name=${name// }

# echo "eve $evaluation $name"
# echo

evaluation.zsh $evaluation $name >>| ~/log/eval-wallpaper.log
