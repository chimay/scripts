am -f
am -h
am -i nvim
am -l
am -q vim
am -r nvim
apt install flatpak # sudo
flatpak history
flatpak install --from https://flathub.org/repo/appstream/com.spotify.Client.flatpakref
flatpak install flathub org.libreoffice.LibreOffice
flatpak list
flatpak list --app
flatpak permission-reset org.libreoffice.LibreOffice
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-delete flathub
flatpak remotes
flatpak repair
flatpak run org.libreoffice.LibreOffice
flatpak search qutebrowser
flatpak uninstall --unused
flatpak uninstall org.libreoffice.LibreOffice
flatpak update
sudo make install PREFIX=/usr/local
