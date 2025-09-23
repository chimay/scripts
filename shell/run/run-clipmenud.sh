#! /usr/bin/env sh

# see also <url:~/racine/config/shell/zsh/zshenv#tn=CM_>
# for configuration

export CM_MAX_CLIPS=3000
export CM_SELECTIONS="clipboard primary secondary"
export CM_IGNORE_WINDOW=".*[Pp]inentry.*"
export CM_LAUNCHER=rofi
export CM_HISTLENGTH=17
export CM_DIR=~/racine/hist/clipmenu

exec clipmenud
