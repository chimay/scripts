#!/usr/bin/env zsh

polybar-msg cmd quit

echo "---" | tee -a ~/log/polybar/superieur.log ~/log/polybar/inferieur.log

polybar -c ~/racine/config/windenv/polybar/hlwm-config superieur >>~/log/polybar/superieur.log 2>&1 &
polybar -c ~/racine/config/windenv/polybar/hlwm-config inferieur >>~/log/polybar/inferieur.log 2>&1 &

echo "Bars launched..."
