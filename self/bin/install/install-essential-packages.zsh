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
	coreutils
	acpi acpid
	network-manager-applet openssh sshfs
	ttf-dejavu
	rsync rclone unison syncthing kdeconnect
	borg python-pyfuse3 restic fuse2 fuse3
	avahi nss-mdns
	zsh tmux fzf
	xterm rxvt-unicode kitty alacritty xfce4-terminal
	less most bat
	calc bc
	git lazygit
	trash-cli
	gvim neovim neovim-qt emacs
	vifm yazi gvfs
	thunar thunar-volman thunar-vcs-plugin
	thunar-archive-plugin thunar-media-tags-plugin
	tree ncdu dfc socat
	atools zip unzip
	dialog
	pass keepassxc
	xorg lightdm lightdm-gtk-greeter
	herbstluftwm
	polybar
	rofi dmenu zenity
	dunst picom xdotool wmctrl xclip xsel
	feh sxiv vimiv exiv2 libwebp-utils i3lock
	xfce4
	neomutt
	qutebrowser firefox
	alsa-utils pipewire wireplumber
	pulsemixer pamixer
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
