#! /usr/bin/env zsh

# vim: set filetype=sh :
# vim: set fdm=marker :

# Chemins d’accès {{{1

source ~/racine/config/cmdline/zsh/zprofile

# }}}1

# Variables {{{1

HOST=`hostname -s`

# }}}1

# Alias {{{1

alias psgrep='ps auxww | grep -v grep | grep --color=never'

# }}}1

#  Matériel {{{1

# Écran {{{2

#xbacklight -set 100

#xset dpms 0 0 234

psgrep redshift-gtk || redshift-gtk >>! ~/log/redshift.log 2>&1 &

# }}}2

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

# Shift_L = %
# Control_L = .
# Super_L = @
# Alt_L = |
# Alt Gr = \
# Super_R = #
# Hyper_R = Menu = ~
# Control_R = /
# Shift_R = ?

xcape -e 'Shift_L=Shift_L|percent;Control_L=Shift_L|period;Super_L=ISO_Level3_Shift|at;Alt_L=ISO_Level3_Shift|ampersand;ISO_Level3_Shift=ISO_Level3_Shift|backslash;Super_R=ISO_Level3_Shift|numbersign;Hyper_R=ISO_Level3_Shift|equal;Control_R=Shift_R|slash;Shift_R=Shift_L|question'

# }}}2

# Souris {{{2

psgrep unclutter || unclutter -display :0.0 -root -jitter 7 -idle 5 &

if [ $HOST = shari ]
then
	synclient TapButton1=1

	synclient VertEdgeScroll=1
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

fi

# }}}2

#  Batterie {{{2

psgrep alarm-battery.zsh || alarm-battery.zsh 30 15 5 60 >>! ~/log/alarm-battery.log 2>&1 &

# }}}2

# Eviter le parquage excessif du disque {{{2

if [ $HOST != mandala ]
then
	psgrep load_cycle_fix || load_cycle_fix.sh >>! ~/log/load_cycle_fix.log 2>&1 &
fi

# }}}2

#  Réseau {{{2

psgrep nm-applet || nm-applet &

if [ $HOST = shari ]
then
	psgrep blueman-applet || blueman-applet &
fi

# }}}2

# }}}1

# Configuration {{{1

# Juste pour être sûr

xrdb -load ~/.Xresources

# }}}1

#  Environnement {{{1

#  Fond d’écran {{{2

psgrep wallpaper || wallpaper.zsh 7 30m ~/racine/pictura/list/wallpaper.meta >>! ~/log/wallpaper.log 2>&1 &

#psgrep xplanet || xplanet -wait 300 -label -labelpos -15+50 -projection rectangular &

# }}}2

# Panel {{{2

polybar.zsh

# }}}2

#  Dock {{{2

#wbar -config ~/racine/config/xwin/dock/wbarrc -pos top-left -vbar -isize 48 -idist 24 -zoomf 2 -jumpf 1 -nanim 5 &
#wbar -config ~/racine/config/xwin/dock/wbarrc -pos top -isize 48 -idist 24 -zoomf 2 -jumpf 1 -nanim 5 &

# }}}2

#  Écran de veille {{{2

#psgrep xscreensaver || xscreensaver -nosplash &

# }}}2

# }}}1

# Services {{{1

# Bindings clavier & souris {{{2

if psgrep sxhkd
then
	pkill -10 sxhkd
else
	sxhkd >>! ~/log/sxhkd.log 2>&1  &
fi

# }}}2

# Presse-papier {{{2

psgrep greenclip || greenclip daemon &

# }}}2

# Terminal {{{2

psgrep urxvtd || urxvtd -q -o -f

# }}}2

# Édition {{{2

#psgrep emacs || emacs --daemon >>! ~/log/emacs-server.log 2>&1 &

# }}}2

# Musique {{{2

[ -p ~/racine/run/pipe/mpv ] || {
	rm -f ~/racine/run/pipe/mpv
	mkfifo ~/racine/run/pipe/mpv
}

psgrep 'mpv --idle --input-file' || \
	mpv \
	--idle \
	--input-file=$HOME/racine/run/pipe/mpv \
	>>! ~/log/mpv-pipe.log 2>&1 &!

[ -S ~/racine/run/socket/mpv ] || rm -f ~/racine/run/socket/mpv

psgrep 'mpv --idle --input-ipc-server' || \
	mpv \
	--idle \
	--input-ipc-server=$HOME/racine/run/socket/mpv \
	>>! ~/log/mpv-socket.log 2>&1 &!

psgrep mpd || { rm -f ~/racine/run/mpd/pid ; mpd ~/racine/config/multimedia/mpd.conf }

# }}}2

#  Horloge {{{2

# Remplacè par clocher.zsh dans crontab

# if [ $HOST = shari ]
# then
# 	psgrep horloge || horloge.zsh -4 -f -i ~/racine/run/clock/horloge.etat >>! ~/log/horloge.log 2>&1 &
# fi

# }}}2

# Compositor {{{2

psgrep picom || picom >>! ~/log/picom.log 2>&1 &

# }}}2

# Notifications {{{2

# Dunst est lancé par
# ~/.local/share/dbus-1/services/org.freedesktop.Notifications.service

# }}}2

# Rappels {{{2

psgrep remind-server || remind-server.zsh 5 >>! ~/log/remind.log 2>&1 &

# }}}2

# Identification {{{2

psgrep polkit-gnome-authentication-agent || \
	/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

psgrep gnome-keyring-daemon || \
	eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg) &

# }}}2

# }}}1

# Message d’accueil {{{1

accueil.zsh >>! ~/log/accueil.log 2>&1 &

# }}}1
