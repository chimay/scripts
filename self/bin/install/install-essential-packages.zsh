#!/usr/bin/env zsh

# during install :
#
# networkmanager

packages=(
  linux-lts
  network-manager-applet openssh rsync
  zsh tmux
  xterm rxvt-unicode kitty alacritty
  vim neovim emacs
  vifm yazi
  tree ncdu dfc socat
  xorg lightdm lightdm-gtk-greeter
  herbstluftwm
  polybar
  rofi dmenu zenity
  dunst picom xdotool wmctrl xclip xsel
  xfce4
  feh sxiv vimiv
  qutebrowser firefox
  alsa-utils pipewire wireplumber
  mpv mplayer
  lilypond timidity fluidsynth freepats-general-midi soundfont-fluid
  kdeconnect syncthing
  acpi cpupower
)

echo -n "Distribution or package manager ? "
read distribution

echo Distribution : $distribution
echo

case $distribution in
	ar|arch|artix|pm|pacman)
		echo "pacman"
		echo
		packages+=(
			pacman-contrib
			pacutils pkgfile expac
			devtools
		)
		sudo pacman -Syy
		sudo pacman -S $=packages
		;;
	void|xbps|xpbs-install)
		echo "xbps"
		echo
		packages+=(xtools)
		sudo xbps-install $=packages
		;;
	*)
		echo Distribution : $distribution
		echo
		;;
esac
