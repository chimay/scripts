#! /usr/bin/env sh

# see also <url:~/racine/config/shell/zsh/zshenv#tn=CM_>
# and <url:~/racine/shell/run/run-clipmenud.sh>
# for configuration

#export CM_DIR=~/racine/hist/clipmenu
export CM_DIR=~/run/clipmenu

export CM_HISTLENGTH=17
export CM_LAUNCHER=rofi

exec clipmenu -dmenu -i
