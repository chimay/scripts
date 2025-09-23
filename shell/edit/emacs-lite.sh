#!/bin/sh

# emacs --no-window-system --init-directory ~config/edit/emacs-lite
# emacs -nw -q --no-splash -l ~/racine/config/edit/emacs-lite/init.el

exec emacs --no-window-system --init-directory ~config/edit/emacs-lite "$@"
