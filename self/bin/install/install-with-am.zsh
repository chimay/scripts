#!/usr/bin/env zsh

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

# -- does not work
#
# viper-browser
#
# -- autres
#
# rclone-browser
# localsend
# dezor
# promethium

packages=(
	freetube
	vieb
	floorp
	zen-browser
	mullvad-browser
	helium-browser
	xnviewmp
)

am install $=packages
