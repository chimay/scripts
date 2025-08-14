#!/usr/bin/env zsh

distribution=${1:-arch}

echo Distribution : $distribution
echo

# during install :
#
# linux linux-lts linux-firmware
# networkmanager

packages=(
	linux linux-lts linux-firmware
	acpi acpid
	network-manager-applet openssh
	rsync unison syncthing kdeconnect
	avahi nss-mdns
	zsh tmux
	git lazygit
	xterm rxvt-unicode kitty alacritty
	vim neovim emacs
	vifm yazi
	tree ncdu dfc socat
	dialog
	xorg lightdm lightdm-gtk-greeter
	herbstluftwm
	polybar
	rofi dmenu zenity
	dunst picom xdotool wmctrl xclip xsel
	xfce4
	feh sxiv vimiv
	qutebrowser firefox
	alsa-utils pipewire pipewire-pulse wireplumber
	mpv mplayer
	lilypond timidity fluidsynth soundfont-fluid
	acpi cpupower
)

case $distribution in
	ar|arch|artix|pm|pacman)
		echo "pacman"
		echo
		packages+=(
			linux-zen
			networkmanager
			pacman-contrib
			pacutils pkgfile expac
			ttf-dejavu ttf-dejavu-nerd
			freepats-general-midi
		)
		sudo pacman -Syy
		sudo pacman -S --needed $=packages
		;;
	void|xbps|xpbs-install)
		echo "xbps"
		echo
		packages+=(
			base-system linux-base
			NetworkManager
			xtools
			freepats
		)
		sudo xbps-install $=packages
		;;
	*)
		echo Distribution : $distribution
		echo
		;;
esac
