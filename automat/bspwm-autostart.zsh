#! /usr/bin/env zsh

# vim: set filetype=sh :
# vim: set fdm=marker :

# Chemins d’accès {{{1

source ~/racine/config/cmdline/zsh/zprofile

# Variables {{{1

HOST=`hostname -s`

# Alias {{{1

alias psgrep='ps auxww | grep -v grep | grep --color=never'

# Environnement de bureau {{{1

#  Fond d’écran {{{2

psgrep wallpaper.zsh || wallpaper.zsh ~/racine/run/wall/wallpaper.status >>! ~/log/wallpaper.log 2>&1 &

# Panel {{{2

# must be launched before services that need system tray

polybar.zsh

#  Dock {{{2

#wbar -config ~/racine/config/xwin/dock/wbarrc -pos top-left -vbar -isize 48 -idist 24 -zoomf 2 -jumpf 1 -nanim 5 &
#wbar -config ~/racine/config/xwin/dock/wbarrc -pos top -isize 48 -idist 24 -zoomf 2 -jumpf 1 -nanim 5 &

#  Écran de veille {{{2

#psgrep xscreensaver || xscreensaver -nosplash &

#  Matériel {{{1
# Écran {{{2

#xbacklight -set 100

xset dpms 0 0 420

psgrep redshift-gtk || run-redshift.sh &

flameshot &

#  Clavier {{{2

if [ $HOST = tixu ]
then
	setxkbmap fr & sleep 1
	xmodmap ~/racine/config/windenv/xmodmap/francais-meta-super-hyper >>! ~/log/xmodmap.log 2>&1 &
else
	setxkbmap be & sleep 1
	xmodmap ~/racine/config/windenv/xmodmap/belge-meta-super-hyper >>! ~/log/xmodmap.log 2>&1 &
fi

if [ $HOST != mandala ]
then
	numlockx on &
fi

# Shift_L = #
# Control_L = *
# Super_L = @
# Alt_L = |
# Alt Gr = \
# Super_R = °
# Hyper_R = Menu = .
# Control_R = /
# Shift_R = ?

chaine=''
chaine+='Shift_L=ISO_Level3_Shift|numbersign;'
chaine+='Control_L=Shift_L|asterisk;'
chaine+='Super_L=ISO_Level3_Shift|at;'
chaine+='Alt_L=ISO_Level3_Shift|bar;'
chaine+='ISO_Level3_Shift=ISO_Level3_Shift|backslash;'
chaine+='Super_R=Shift_L|degree;'
chaine+='Hyper_R=Shift_L|period;'
chaine+='Control_R=Shift_R|slash;'
chaine+='Shift_R=Shift_L|question'

xcape -e $chaine

# Souris {{{2

psgrep unclutter || unclutter -display :0.0 -root -jitter 7 -idle 5 &

if [ $HOST = shari ]
then
	synclient TapButton1=1

	#synclient VertEdgeScroll=1
	synclient HorizEdgeScroll=1

	synclient LBCornerButton=2
	synclient RBCornerButton=3

elif [ $HOST = quigonjinn ]
then
	xinput set-prop 17 289 1

elif [ $HOST = tixu ]
then

elif [ $HOST = mandala ]
then
	# L’id change à chaque démarrage
	#iden=$(xinput list | grep SynPS | cut -d '=' -f 2 | awk '{print $1}')
	#xinput set-prop $iden 'libinput Tapping Enabled' 1

elif [ $HOST = taijitu ]
then
	# L’id change à chaque démarrage
	iden=$(xinput list | grep SynPS | cut -d '=' -f 2 | awk '{print $1}')
	xinput set-prop $iden 'libinput Tapping Enabled' 1
fi

# Stockage {{{2

# udiskie --no-automount --notify --tray >>! ~/log/udiskie.log 2>&1 &

#  Batterie {{{2

if [ $HOST = quigonjinn ]
then
else
	psgrep alarm-battery.zsh || alarm-battery.zsh 30 15 5 60 >>! ~/log/alarm-battery.log 2>&1 &
fi

# Mémoire {{{2

psgrep alarm-memory.zsh || alarm-memory.zsh 9 >>! ~/log/alarm-memory.log 2>&1 &

# Température {{{2

if [ $HOST = shari ]
then
	psgrep alarm-sensor.zsh || alarm-sensor.zsh +91 ++94 -30 >>! ~/log/alarm-sensor.log 2>&1 &
elif [ $HOST = mandala ]
then
	psgrep alarm-sensor.zsh || alarm-sensor.zsh +80 ++85 -30 >>! ~/log/alarm-sensor.log 2>&1 &
elif [ $HOST = taijitu ]
then
	psgrep alarm-sensor.zsh || alarm-sensor.zsh +82 ++87 -30 >>! ~/log/alarm-sensor.log 2>&1 &
elif [ $HOST = tixu ]
then
	psgrep alarm-sensor.zsh || alarm-sensor.zsh +82 ++87 -30 >>! ~/log/alarm-sensor.log 2>&1 &
fi

# Eviter le parquage excessif du disque {{{2

if [ $HOST != mandala ]
then
	psgrep load_cycle_fix || load_cycle_fix.sh >>! ~/log/load_cycle_fix.log 2>&1 &
fi

#  Réseau {{{2

psgrep nm-applet || nm-applet &

if [ $HOST = taijitu ]
then
	psgrep protonvpn-app || protonvpn-app >>! ~/log/protonvpn-app.log 2>&1 &
elif [ $HOST = shari ]
then
	psgrep protonvpn-app || protonvpn-app >>! ~/log/protonvpn-app.log 2>&1 &
fi

# Bluetooth {{{2

psgrep blueman-applet || blueman-applet &

# Configuration {{{1

# Juste pour être sûr

xrdb -load ~/.Xresources

# Services {{{1
# Bindings clavier & souris {{{2

if psgrep sxhkd
then
	pkill -10 sxhkd
else
	sxhkd -c ~/racine/config/windenv/sxhkd/bspwm-sxhkdrc >>! ~/log/sxhkd.log 2>&1  &
fi

psgrep keynav || keynav daemonize

# Compositor {{{2

psgrep picom || picom >>! ~/log/picom.log 2>&1 &

# Identification {{{2

psgrep polkit-gnome-authentication-agent || \
	/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

psgrep gnome-keyring-daemon || \
	eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg) &

# Terminal {{{2

psgrep urxvtd || urxvtd -q -o -f

# Édition {{{2

# Pour éviter les conflits entre PC,
# il vaut mieux les lancer manuellement

# psgrep nvim || run-neovim-server.sh &
# psgrep kak || run-kak-server.sh &

# Presse-papier {{{2

#psgrep greenclip || run-greenclip.sh &
psgrep clipmenud || run-clipmenud.sh &

# Notifications {{{2

# Dunst est lancé par
# ~/.local/share/dbus-1/services/org.freedesktop.Notifications.service

log-notifications.bash ~/log/notifications.log &

# Rappels {{{2

psgrep remind-server || {
	remind-server.zsh ~/racine/config/organizer/remind/reminders 5 >>! ~/log/remind.log 2>&1 &
}

# Musique {{{2

[ -S ~/racine/run/socket/mpv ] || rm -f ~/racine/run/socket/mpv

psgrep 'mpv --idle --input-ipc-server' || \
	mpv \
	--idle \
	--input-ipc-server=$HOME/racine/run/socket/mpv \
	>>! ~/log/mpv-socket.log 2>&1 &!

psgrep mpd || { rm -f ~/racine/run/mpd/pid ; mpd ~/racine/config/multimedia/mpd.conf }

psgrep timidity || run-timidity-server.sh

#  Horloge {{{2

if [ $HOST = taijitu -o $HOST = mandala  ]
then
	psgrep clock || clock.zsh ~/racine/run/clock/clock.status >>! ~/log/clock.log 2>&1 &
fi

# Synchronisation {{{2

psgrep syncthing || syncthing.sh &

# Téléchargements {{{2

# dad runs :
# aria2c --daemon --enable-rpc --continue --dir ~/racine/gate/download --input-file ~/.local/share/diana.session --save-session ~/.local/share/diana.session

psgrep aria2c || {
	dad -d ~/racine/gate/download start
}

psgrep transmission || transmission-daemon

# Social {{{2

if [ $HOST = taijitu ]
then
	#hexchat --minimize=2 -a &
	#run-quassel.sh &
	run-element.sh &
fi

#  Téléphone {{{2

psgrep kdeconnect || kdeconnect-indicator &

# Événements {{{1

bspwm-subscribe.zsh >>! ~/log/bspwm-subscribe.log 2>&1

# Message d’accueil {{{1

welcome.zsh >>! ~/log/accueil.log 2>&1 &
