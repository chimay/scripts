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

# Configuration {{{1

# Juste pour être sûr

xrdb -load ~/.Xresources

# }}}1

#  Environnement {{{1

#  Fond d’écran {{{2

psgrep fond-ecran || fond-ecran.zsh 7 +30 ~/graphix/list/wallpaper.gen >>! ~/log/fond-ecran.log &

#psgrep xplanet || xplanet -wait 300 -label -labelpos -15+50 -projection rectangular &

# }}}2

# Panel {{{2

#[ $HOST = shari ] && xfce4-panel &

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

xbindkeys

# }}}2

# Presse-papier {{{2

greenclip daemon &

# }}}2

# Terminal {{{2

psgrep urxvtd || urxvtd -q -o -f

# }}}2

# Édition {{{2

#psgrep emacs || emacs --daemon >>! ~/log/emacs-server.log 2>&1 &

# }}}2

# Musique {{{2

psgrep mpd || { rm -f ~/racine/run/mpd/pid ; mpd ~/racine/config/music/mpd.conf }

psgrep mpv || \
	mpv \
	--idle \
	--input-file=$HOME/racine/run/fifo/mpv \
	&>>! ~/log/mpv.log &!

# }}}2

#  Horloge {{{2

if [ $HOST = shari ]
then
	psgrep horloge || horloge.zsh -4 -f -i ~/racine/run/clock/horloge.etat >>! ~/log/horloge.log 2>&1 &
fi

# }}}2

# }}}1

#  Matériel {{{1

# Écran {{{2

#xbacklight -set 100

#xset dpms 0 0 234

psgrep redshift || redshift-gtk >>! ~/log/redshift.log 2>&1 &

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

# }}}2

# Souris {{{2

psgrep unclutter || unclutter -display :0.0 -root -jitter 7 -idle 5 &

synclient TapButton1=1

synclient VertEdgeScroll=1
synclient HorizEdgeScroll=1

synclient LBCornerButton=2
synclient RBCornerButton=3

# }}}2

#  Batterie {{{2

if [ $HOST = shari ] || [ $HOST = tixu ]
then
	start-alarm-bat.zsh 15 10 5 3 2>&1 >>! ~/log/alerteBatterie.log &
fi

# }}}2

# Eviter le parquage excessif du disque {{{2

psgrep load_cycle_fix || load_cycle_fix.sh &

# }}}2

#  Réseau {{{2

psgrep nm-applet || nm-applet &

if [ $HOST = shari ]
then
	psgrep blueman-applet || blueman-applet &
fi

# }}}2

# }}}1
