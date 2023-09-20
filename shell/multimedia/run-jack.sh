#!/bin/sh

jack_control eps realtime False
jack_control dps period 64
jack_control ds alsa
jack_control dps device hw:HD2
jack_control dps rate 44100
jack_control dps nperiods 2
dbus-launch jack_control start
sleep 10
a2j_control --ehw
a2j_control --start
#sleep 10
#qjackctl &
