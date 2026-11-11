#!/usr/bin/env zsh

# bootstrap {{{1

# see : https://github.com/ivan-hc/AM

# wget -q https://raw.githubusercontent.com/ivan-hc/AM/main/AM-INSTALLER
# chmod a+x ./AM-INSTALLER
# ./AM-INSTALLER
# rm ./AM-INSTALLER
#
# ---- OR ----
#
# wget https://raw.githubusercontent.com/ivan-hc/AM/main/INSTALL
# chmod a+x ./INSTALL
# sudo ./INSTALL
# rm ./INSTALL

which am &> /dev/null || {
	am_installer=~/racine/source/software/AM/AM-INSTALLER
	chmod +x $am_installer
	$am_installer
}

# ideas {{{1

# vieb
# vimma
# mullvad-browser
# elixiroffice
#
# rclone-browser
# localsend
# dezor
# promethium
# replaced by gwenview : xnviewmp
# sioyek : better with aur to be configured

# issues {{{1

# -- does not work
#
# viper-browser

# init {{{1

packages=()

# syncron {{{1

packages+=(
	#airclone
)

# browser {{{1

packages+=(
	floorp
	waterfox
	zen-browser
	#helium
)

# multimedia {{{1

packages+=(
	freetube
)

# document {{{1

packages+=(
	sioyek
)

# am sync {{{1

echo "am sync"
echo

am sync

# update {{{1

echo "am update"
echo

am update

# install {{{1

echo "am install $=packages"
echo

am install $=packages
