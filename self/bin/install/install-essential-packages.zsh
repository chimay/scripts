#!/usr/bin/env zsh

distribution=${1:-arch}

echo Distribution : $distribution
echo

# during install :
#
# linux linux-lts linux-firmware
# networkmanager

# aur :
#
# abook procmail urlview
# task-spooler-cpu
# mp3splt-bin mp3wrap-bin
# pico2wave-shell pico-tts
# nodejs-readability
# udevil-git
# steghide stegseek
#
# vieb-bin
# floorp-bin
# mullvad-browser-bin
# zen-browser-bin
# helium-browser-bin
# tradingview
#
# sc-im
# cssc

packages=(
	coreutils
	acpi acpid
	network-manager-applet openssh sshfs
	ttf-dejavu
	rsync rclone unison syncthing kdeconnect
	borg python-pyfuse3 restic fuse2 fuse3
	avahi nss-mdns
	zsh tmux fzf fzy zoxide
	xterm rxvt-unicode kitty alacritty xfce4-terminal
	htop btop procs
	less most bat
	calc bc
	git lazygit
	trash-cli
	gvim neovim neovim-qt emacs
	vifm yazi xplr gvfs
	thunar thunar-volman thunar-vcs-plugin
	thunar-archive-plugin thunar-media-tags-plugin
	tree ncdu dfc socat
	atools zip unzip
	dialog
	make gcc patch automake autoconf fakeroot pkgconf debugedit
	pass keepassxc
	xorg xf86-input-synaptics
	lightdm lightdm-gtk-greeter
	herbstluftwm sxhkd
	polybar
	rofi dmenu zenity
	dunst remind picom
	xdotool wmctrl xclip xsel xorg-xprop
	unclutter
	feh sxiv vimiv exiv2 libwebp-utils i3lock
	redshift
	xfce4
	isync opensmtpd
	s-nail
	neomutt aerc
	zathura zathura-pdf-mupdf zathura-ps
	w3m qutebrowser palemoon firefox
	lighttpd
	tor torsocks nyx torbrowser-launcher proton-vpn-gtk-app
	samba
	translate-shell
	pandoc jq
	texlive-meta
	pdf2svg
	rubygems
	octave
	alsa-utils pipewire wireplumber
	pulsemixer pamixer pavucontrol pavucontrol-qt
	mpv mplayer
	mpd mpc ncmpcpp
	sox libttspico-utils
	lilypond timidity fluidsynth soundfont-fluid
	acpi cpupower turbostat thermald
	android-tools androit-file-transfer
)

case $distribution in
	arch|archlinux)
		echo "arch"
		echo
		packages+=(
			linux linux-lts linux-firmware linux-zen
			networkmanager
			pacman-contrib
			pacutils pkgfile expac
			pipewire-pulse
			freepats-general-midi
			arch-wiki-docs arch-wiki-lite
		)
		sudo pacman -Syy
		sudo pacman -S --needed $=packages
		;;
	manjaro)
		echo "manjaro"
		echo
		packages+=(
			linux-meta
			linux-r8168-meta
			linux-lts-r8168-meta
			networkmanager
			pacman-contrib
			pacutils pkgfile expac
			yay
			ueberzugpp
			pipewire-pulse
			freepats-general-midi
			arch-wiki-docs arch-wiki-lite
			hplip
		)
		sudo pacman -Syy
		sudo pacman -S --needed $=packages
		;;
	artix)
		echo "artix"
		echo
		# prevents login with lightdm
			# pam_rundir
		# dinit-user-spawn or turnstile turnstile-dinit
		packages+=(
			linux-zen
			networkmanager
			pacman-contrib
			pacutils pkgfile expac
			pipewire-pulse
			freepats-general-midi
			arch-wiki-docs arch-wiki-lite
			dinit-user-spawn
			zramen zramen-dinit
			thermald-dinit
		)
		sudo pacman -Syy
		sudo pacman -S --needed $=packages
		;;
	void|voidlinux)
		echo "void"
		echo
		packages+=(
			base-system linux-base
			NetworkManager
			xtools
			pam_rundir
			alsa-pipewire
			freepats
		)
		sudo xbps-install $=packages
		;;
	freebsd)
		echo "freebsd"
		echo
		packages=(
			networkmgr
			avahi nss_mdns
			rsync unison
			py311-borgbackup restic
			zsh tmux fd-find ripgrep fzf perl5
			git lazygit
			py311-trash-cli
			vim vim-gtk3 neovim neovim-qt
			tree ncdu dfc socat
			password-store
			xorg lightdm lightdm-gtk-greeter
			polybar
			rofi dmenu zenity
			dunst picom xdotool wmctrl-fork xclip xsel-conrad
			feh nsxiv
			clipmenu
			pulseaudio gtk-mixer
			neomutt
			qutebrowser firefox
			alsa-utils alsa-seq-server
			lilypond timidity fluidsynth fluid-soundfont
			pftop
			bastille debootstrap
			vm-bhyve grub2-bhyve bhyve-firmware
		)
		sudo pkg install $=packages
		;;
	*)
		echo Distribution : $distribution
		echo
		;;
esac
