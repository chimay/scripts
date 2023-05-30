#!/usr/bin/env sh

systemctl --user start timidity.service
#systemctl --user start fluidsynth.service

goto-or-run.sh frescobaldi

systemctl --user stop timidity.service
#systemctl --user stop fluidsynth.service
