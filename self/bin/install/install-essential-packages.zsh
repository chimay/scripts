#!/usr/bin/env zsh

paquets=(
	xorg-xauth
	cmake
	unzip
	texlive-core
	texlive-bin
	perl-anyevent-i3
	perl-json-xs

	util-linux
	gptfdisk
	parted
	hdparm
	smartmontools
	wipe
	grub
	os-prober
	pacman-contrib
	pkgfile
	asp
	lsb-release
	lightdm
	lightdm-gtk-greeter
	lightdm-gtk-greeter-settings
	i3
	xorg-xrdb
	wmctrl
	xorg-xprop
	xorg-xwininfo
	xdotool
	xbindkeys
	xsel
	xclip
	xorg-xinput
	rofi
	dmenu
	zenity
	xfce4-appfinder
	dunst
	unclutter
	xorg-xbacklight
	redshift
	bluez
	bluez-utils
	blueman
	yakuake
	xterm
	rxvt-unicode
	rxvt-unicode-terminfo
	urxvt-perls
	tilix
	tmux
	kbd
	zsh
	bash
	fish
	openssh
	pssh
	reptyr
	multitail
	procps-ng
	fzf
	fasd
	ed
	sed
	gawk
	gvim
	neovim
	emacs
	less
	lesspipe
	vimpager
	atool
	stow
	vifm
	ranger
	caja
	renameutils
	detox
	ctags
	the_silver_searcher
	ack
	diffutils
	patch
	clisp
	python
	ruby
	perl
	lua
	ocaml
	jdk8-openjdk
	jre8-openjdk
	icedtea-web
	ncdu
	dfc
	hardlink
	calc
	at
	cronie
	task
	calcurse
	networkmanager
	network-manager-applet
	avahi
	nss-mdns
	getmail
	procmail
	s-nail
	neomutt
	abook
	newsboat
	filezilla
	surfraw
	w3m
	elinks
	qutebrowser
	ccrypt
	gnupg
	pass
	pwsafe
	keepassx
	pandoc
	pandoc-citeproc
	pandoc-crossref
	libreoffice-fresh
	udevil
	gvfs-mtp
	mtpfs
	udisks2
	rsync
	unison
	rcs
	cvs
	subversion
	git
	mercurial
	trash-cli
	zathura
	zathura-pdf-mupdf
	vimiv
	sxiv
	feh
	cups
	hplip
	foomatic-db
	foomatic-db-engine
	foomatic-db-ppds
	foomatic-db-gutenprint-ppds
	foomatic-db-nonfree
	foomatic-db-nonfree-ppds
	gutenprin
	simple-scan
	alsa-utils
	pulseaudio
	libpulse
	pulseaudio-alsa
	pulseaudio-bluetooth
	pamixer
	pulsemixer
	pavucontrol
	moc
	cmus
	mpd
	mpc
	ncmpcpp
	festival
	festival-english
	vlc
	mplayer
	mpv
	youtube-viewer
	playerctl
	imagemagick
	geogebra
	sox
	musescore
	lilypond
	octave
	r
	arch-wiki-lite
	gcompris
	wesnoth
)

print Installation de :
echo
print -l $=paquets | sed 's/^/	/'
echo

sudo pacman -Syy

sudo pacman -S $=paquets

aurpack=(
	rofi-greenclip-beta
	task-spooler
	urlview
	urlscan-git
	sc-im-git
	vit
	kpcli
	bashmount
	ncpamixer
	yay
	trizen
	svox-pico-git
)

print Installation par AUR de :
echo
print -l $=aurpack | sed 's/^/	/'
echo

sudo trizen -S $=aurpack

print Installation des dépôts Github
echo

# Voir :
#
# Buku
# buku_run
# bookmarks

clone-source.sh
