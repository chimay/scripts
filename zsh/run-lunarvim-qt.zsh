#! /usr/bin/env sh

exec nvim-qt --nvim  "$HOME/racine/local/bin/lvim" "$@" >> ~/log/lunarvim-qt.log 2>&1
