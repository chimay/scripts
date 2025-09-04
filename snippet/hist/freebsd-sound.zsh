# midi 1. does not work
# midi 2. possibility to recompile fluidsynth from port with alsa support ?
aconnect -l
aconnect 1:0 2:0
fluidsynth -s -a oss -m alsa_seq /usr/local/share/sounds/sf2/FluidR3_GM.sf2
sudo pkg install -y alsa-utils alsa-seq-server timidity fluidsynth
