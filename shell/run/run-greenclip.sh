#! /usr/bin/env sh

backup=$hOME/racine/config/windenv/greenclip/greenclip.cfg.bak
config=$hOME/racine/config/windenv/greenclip/greenclip.cfg

cp -f "$backup" "$config"

greenclip daemon
