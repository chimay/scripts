#!/usr/bin/env zsh

packages=(
  linux-lts
  networkmanager network-manager-applet openssh
  zsh tmux
  xterm rxvt-unicode kitty alacritty
  vim neovim emacs
  vifm yazi
  tree ncdu dfc
  xorg lightdm lightdm-gtk-greeter
  herbstluftwm polybar rofi dmenu dunst picom xdotool wmctrl xclip xsel
  xfce4
  feh sxiv vimiv
  qutebrowser firefox
  alsa-utils pipewire wireplumber
  lilypond timidity fluidsynth freepats-general-midi soundfont-fluid
)

echo -n "Distribution or package manager ? "
read distribution

echo Distribution : $distribution
echo

case $distribution in
	ar|arch|artix|pm|pacman)
		echo "pacman"
		echo
		packages+=(pacman-contrib)
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
