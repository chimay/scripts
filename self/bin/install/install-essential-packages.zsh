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
	dialog
	pass
	xorg lightdm lightdm-gtk-greeter
	herbstluftwm
	polybar
	rofi dmenu zenity
	dunst picom xdotool wmctrl xclip xsel
	xfce4
	feh sxiv vimiv
	neomutt
	qutebrowser firefox
	alsa-utils pipewire wireplumber
	pulsemixer pamixer ncpamixer
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
			pipewire-pulse
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
			alsa-pipewire
			freepats
		)
		sudo xbps-install $=packages
		;;
	freebsd|freeb|pkgng)
		echo "pkg"
		echo
		packages=(
			networkmgr
			avahi nss_mdns
			rsync unison
			py311-borgbackup restic
			zsh tmux fzf ripgrep perl5
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
			lilypond timidity fluidsynth fluid-soundfont
			bastille
		)
		sudo pkg install $=packages
		;;
	*)
		echo Distribution : $distribution
		echo
		;;
esac
