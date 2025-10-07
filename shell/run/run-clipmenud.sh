#! /usr/bin/env sh

# see also <url:~/racine/config/shell/zsh/zshenv#tn=CM_>
# and <url:~/racine/shell/windenv/rofi-clipmenu.zsh>
# for configuration

#export CM_DIR=~/racine/hist/clipmenu
export CM_DIR=~/clipmenu

export CM_MAX_CLIPS=3000
export CM_SELECTIONS="clipboard primary secondary"
export CM_IGNORE_WINDOW=".*[Pp]inentry.*"

exec clipmenud
