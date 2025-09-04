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
# abook

packages=(
	linux linux-lts linux-firmware
	acpi acpid
	network-manager-applet openssh
	rsync rclone unison syncthing kdeconnect
	borg restic
	avahi nss-mdns
	zsh tmux fzf
	calc bc
	git lazygit
	trash-cli
	xterm rxvt-unicode kitty alacritty
	gvim neovim neovim-qt emacs
	vifm yazi
	tree ncdu dfc socat
	atools zip unzip
	dialog
	pass keepassxc
	xorg lightdm lightdm-gtk-greeter
	herbstluftwm
	polybar
	rofi dmenu zenity
	dunst picom xdotool wmctrl xclip xsel
	feh sxiv vimiv i3lock
	xfce4
	neomutt
	qutebrowser firefox
	alsa-utils pipewire wireplumber
	pulsemixer pamixer ncpamixer
	mpv mplayer
	lilypond timidity fluidsynth soundfont-fluid
	acpi cpupower turbostat thermald
)

case $distribution in
	arch|archlinux)
		echo "arch"
		echo
		packages+=(
			linux-zen
			networkmanager
			pacman-contrib
			pacutils pkgfile expac
			ttf-dejavu ttf-nerd-fonts-symbol
			pipewire-pulse
			freepats-general-midi
			arch-wiki-docs arch-wiki-lite
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
			ttf-dejavu ttf-nerd-fonts-symbol
			dinit-user-spawn
			pipewire-pulse
			freepats-general-midi
			arch-wiki-docs arch-wiki-lite
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
			xterm rxvt-unicode kitty alacritty
			vim vim-gtk3 neovim neovim-qt
			vifm yazi
			tree ncdu dfc socat
			password-store
			xorg lightdm lightdm-gtk-greeter
			herbstluftwm
			polybar
			rofi dmenu zenity
			dunst picom xdotool wmctrl-fork xclip xsel-conrad
			feh nsxiv
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
