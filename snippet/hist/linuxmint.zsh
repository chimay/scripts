# apt autoremove
# apt clean
apt autoclean # sudo
apt install build-essential checkinstall # sudo
apt install flatpak # sudo, déjà installé ?
apt install mintupgrade # sudo
apt install snapd # sudo
apt-file search notify-send
apt-file update # sudo
clavier=1 ; onboard&!
flatpak install --from https://flathub.org/repo/appstream/com.spotify.Client.flatpakref
flatpak install <path_of_flatpakref_file>
flatpak install flathub org.libreoffice.LibreOffice
flatpak list
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo # déjà configuré ?
flatpak run <package-name>
flatpak search qutebrowser
flatpak uninstall <application_id>
flatpak update
install=unison ; sudo cp ./src/unison /usr/local/bin
mintupgrade check
mintupgrade download
mintupgrade upgrade
monte=diskext-sdb1 ; udevil mount /dev/sdb1 /media/user_name/diskext-sdb1
signal=i3blocks-mpd ; k -36 $(pid i3blocks)
signal=i3blocks-volume ; k -35 $(pid i3blocks)
snap changes
snap find qutebrowser
snap list
sudo make install PREFIX=/usr/local
sudo snap install qutebrowser
sudo snap refresh qutebrowser
sudo snap remove qutebrowser
sudo systemctl enable --now snapd.socket # pas nécessaire sur mint
sync=cleusb ; sn ~syncron/cleusb/ /media/cleusb/syncron
~source/unison-2.51.2 && make UISTYLE=text
nmcli networking connectivity
sudo ln -s ~/.w3m/cgi-bin/*clipboard* /usr/lib/w3m/cgi-bin
