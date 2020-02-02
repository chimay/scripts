#!/usr/bin/env zsh

# Terminate already running bar instances
# killall -q polybar
# If all your bars have ipc enabled, you can also use
polybar-msg cmd quit

echo "---" | tee -a ~/log/polybar-superieur.log ~/log/polybar-inferieur.log

polybar superieur >>~/log/polybar-superieur.log 2>&1 &
polybar inferieur >>~/log/polybar-inferieur.log 2>&1 &

echo "Bars launched..."
