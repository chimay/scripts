#!/usr/bin/env zsh

distribution=${1:-arch}
supplement=${2:-none}

echo Distribution : $distribution
echo

# during install {{{1

# linux linux-lts linux-firmware
# networkmanager

# issues {{{1

# interferes with dms shell notification {{{2

# dunst
# swaync fnott mako
#
# utiliser :
#
# systemctl --user mask --now <notif-service>.service

# init {{{1

packages=()
packages_aur=()

# generic packages {{{1

# base {{{2

packages+=(
	linux-firmware
	coreutils
	acpi acpid
	procps-ng psmisc
)

# package managers {{{2

packages+=(
	pacman-contrib
	pacutils pkgfile expac
)

# file systems {{{2

packages+=(
	python-pyfuse3 fuse2 fuse3
)

# terminal {{{2

packages+=(
	kitty ghostty
	alacritty
	wezterm
	xterm rxvt-unicode
	xfce4-terminal
)

# terminal multiplexer {{{2

packages+=(
	tmux zellij
)

# shell {{{2

packages+=(
	zsh fish elvish xonsh
	sudo opendoas polkit
)

# remote shell {{{2

packages+=(
	openssh sshfs
	ttyd
	croc magic-wormhole
)

# network {{{2

packages+=(
	networkmanager network-manager-applet
	avahi nss-mdns
)

# archives {{{2

packages+=(
	atools zip unzip
	cpio
)

# backup {{{2

packages+=(
	borg borgmatic
	restic
)

# synchronization {{{2

packages+=(
	rsync
	rclone
	unison
	syncthing kdeconnect
)

# utils {{{2

packages+=(
	eza tree ncdu dfc socat
	htop btop bottom glances
	procs
	fdupes jdupes
	detox
	calc bc
	logrotate
	trash-cli
	dialog
)

# development {{{2

packages+=(
	git git-delta lazygit tig
	gcc make cmake automake autoconf
	patch fakeroot pkgconf debugedit
	byacc bison
	rust cargo cargo-binstall
	zig
	perl cpanminus perl-cpanplus
	ruby rubygems
	python python-pip ipython
	python-numpy python-matplotlib python-scipy
	octave
	ocaml opam
	lua luarocks
	mujs npm mathjax
	mise bob
)

# search {{{2

packages+=(
	fzf fzy zoxide
	#atuin
	fd plocate
	ripgrep ripgrep-all repgrep ugrep
	grex
)

# view {{{2

packages+=(
	less most bat
)

# edit {{{2

packages+=(
	rlwrap
	ed gvim
	neovim neovim-qt python-pynvim
	tree-sitter-cli
	pyright python-debugpy
	emacs
	kakoune helix
	retext marker apostrophe ghostwriter
	ctags
	# -- conflict with imv
	#renameutils
)

# file managers {{{2

packages+=(
	vifm yazi xplr ranger superfile
	gvfs openslide atool fuse-zip python-piexif
	thunar thunar-volman thunar-vcs-plugin gigolo
	thunar-archive-plugin thunar-media-tags-plugin
)

# organize {{{2

packages+=(
	cronie at remind
)

# keys {{{2

packages+=(
	gnupg gpg-tui age
	pass pass-otp keepassxc
	gnome-keyring
)

# fonts {{{2

packages+=(
	ttf-dejavu ttf-droid ttf-inconsolata
	adwaita-fonts
	noto-fonts
	ttf-jetbrains-mono-nerd
)

# display managers {{{2

packages+=(
	ly lemurs emptty
	lightdm lightdm-gtk-greeter
	sddm
	gdm
	greetd greetd-regreet greetd-tuigreet greetd-gtkgreet nwg-hello
)

# graphic libraries themes {{{2

packages+=(
	nwg-look
	qt6ct
)

# xorg {{{2

packages+=(
	xorg xf86-input-synaptics
	xorg-xwininfo xorg-xprop xorg-xrandr xorg-xdpyinfo
	brightnessctl
	xdotool wmctrl xclip xsel
	libxkbcommon xorg-xkbcomp xorg-xmodmap sxhkd keyd xorg-xev
	xorg-xrdb
	x11vnc tigervnc
	polybar
	rofi dmenu zenity
	clipmenu
	dunst
	picom
	unclutter
	redshift
	i3lock
	polkit-gnome
	xfce4 herbstluftwm
)

# wayland {{{2

packages+=(
	wayland wayland-utils
	xorg-xwayland xwayland-satellite
	qt6-wayland qt5-wayland
	uwsm
	nwg-displays
	wev
	wtype ydotool
	wl-clipboard cliphist nwg-clipman copyq
	wlsunset gammastep
	awww
	mako
	wf-recorder
	wayvnc
	foot
	fuzzel wmenu wofi
	grim slurp
	xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk
	waybar
	quickshell
	dms-shell dms-shell-hyprland dms-shell-niri
	noctalia
	wtype
	wayfire wcm wf-config
	waypipe waylock
	sway swaybg swayidle swaylock
	hyprland hyprtoolkit hyprutils hyprwire hyprlang
	hyprland-guiutils hyprland-protocols hyprcursor
	hyprlauncher hyprshutdown
	hyprpaper hyprsunset hyprpicker
    hypridle hyprlock hyprpolkitagent
	hyprshot hyprgraphics
	hyprpwcenter
	xdg-desktop-portal-hyprland hyprland-qt-support
	niri dms-shell-niri
	river-classic
)

# browser {{{2

packages+=(
	w3m links elinks
	wget curl
	qutebrowser python-tldextract
	firefox
	lighttpd
	tor torsocks nyx torbrowser-launcher proton-vpn-gtk-app
)

# mail {{{2

packages+=(
	isync opensmtpd
	s-nail
	neomutt aerc

)

# social {{{2

packages+=(
	weechat irssi
)

# sharing {{{2

packages+=(
	samba
)

# document {{{2

packages+=(
	texlive-meta # latex and stuff
	texlive-langfrench
	pandoc jq
	zathura zathura-pdf-mupdf zathura-ps
	pdf2svg inkscape
)

# office {{{2

packages+=(
	libreoffice-fresh
	system-config-printer cups sane
	hplip
	simple-scan
)

# colors {{{2

packages+=(
	pastel
)

# images {{{2

packages+=(
	graphicsmagick imagemagick
	feh sxiv nsxiv imv
	vimiv viu
	exiv2 libwebp-utils
	gwenview scrot
)

# audio {{{2

packages+=(
	alsa-utils
	pipewire pipewire-alsa pipewire-pulse pipewire-jack
	pipewire-session-manager wireplumber
	wiremix
	helvum
	pulsemixer pamixer pavucontrol pavucontrol-qt
	sox
)

# music {{{2

packages+=(
	mpd mpd-mpris
	mpc ncmpcpp rmpc
	timidity fluidsynth
	freepats-general-midi soundfont-fluid
	lilypond frescobaldi musescore
)

# multimedia {{{2

packages+=(
	mpv mplayer
	vlc vlc-plugins-all vlc-cli vlc-gui-ncurses
	playerctl
)

# documentation {{{2

packages+=(
	man-db # or mandoc
	arch-wiki-docs arch-wiki-lite
)

# others {{{2

packages+=(
	translate-shell
	python-pillow python-reportlab python-pyqt5 libusb rpcbind
	acpi cpupower turbostat thermald
	android-tools android-file-transfer
	pcsclite p11-kit pcsc-tools ccid acsccid pinentry opensc # eid stuff
	gtk3 libassuan openssl libxml2 libproxy
)

#print -l $packages

# manjaro {{{1

if [ $distribution = manjaro ]
then
	echo "manjaro"
	echo
	packages+=(
		linux-meta
		linux-r8168-meta
		linux-lts-r8168-meta
		yay
		ueberzugpp
	)
	echo "sudo pacman -Syy"
	echo "sudo pacman -S --needed $=packages"
	echo
	sudo pacman -Syy
	sudo pacman -S --needed $=packages
fi

# archlinux {{{1

if [ $distribution = archlinux ]
then
	echo "arch"
	echo
	packages+=(
		linux linux-lts linux-zen
	)
	echo "sudo pacman -Syy"
	echo "sudo pacman -S --needed $=packages"
	echo
	sudo pacman -Syy
	sudo pacman -S --needed $=packages
fi

# aur : arch user repository {{{1

[ $supplement = aur ] || exit 0

# helpers {{{2

packages_aur+=(
	yay aura-bin
)

# terminal multiplexer {{{2

packages+=(
	#herdr-bin
)

# synchronization {{{2

packages_aur+=(
	lazyrsync-bin
)

# pluggable devices {{{2

packages_aur+=(
	udevil
)

# archives {{{2

packages_aur+=(
	archivemount
)

# development {{{2

packages_aur+=(
	#cssc
	vscodium-bin
)

# keys {{{2

packages_aur+=(
	#steghide stegseek
)

# wayland {{{2

packages_aur+=(
	#hyprshell
)

# browser {{{2

packages_aur+=(
	#nodejs-readability-cli
	#curlmirror crawley-bin
)

# mail {{{2

packages_aur+=(
	abook procmail
	#urlview
)

# music {{{2

packages_aur+=(
	#mp3splt-bin mp3wrap-bin
)

# vocal synthesis {{{2

packages_aur+=(
	pico2wave-shell pico-tts
)

# document {{{2

packages_aur+=(
	sioyek-git
)

# office {{{2

packages_aur+=(
	sc-im
	tradingview
)

# others {{{2

packages_aur+=(
	task-spooler-cpu
)

# apply pikaur {{{2

echo "pikaur -S --needed $=packages_aur"
echo
pikaur -S --needed $=packages_aur
