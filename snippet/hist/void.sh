source_repo=boootstrap ; ./xbps-src binary-bootstrap
source_repo=build ; ./xbps-src pkg -o nonfree -f intel-media-driver
source_repo=build ; ./xbps-src pkg paquet
source_repo=git ; git clone https://github.com/void-linux/void-packages.git
source_repo=help ; ./xbps-src -h
source_repo=install ; xbps-install --repository ./hostdir/binpkgs paquet
source_repo=show-options ; ./xbps-src show-options intel-media-driver
sudo echo "KEYMAP=be" >> /etc/rc.conf
sudo echo "echo bye" >> /etc/rc.conf.shutdown
sudo echo "echo hello" >> /etc/rc.conf.local
sudo ln -s /etc/sv/sshd /etc/runit/runsvdir/default
sudo ln -s /etc/sv/sshd /var/service
sudo vim /etc/default/libc-locales
sudo vkpurge rm all
sudo xbps-install -S octoxbps
sudo xbps-install -S void-repo-multilib
sudo xbps-install -S void-repo-multilib-nonfree
sudo xbps-install -S void-repo-nonfree
sudo xbps-install -S xtools
sudo xbps-install -Su
sudo xbps-install -Su xbps
sudo xbps-reconfigure -f glibc-locales
sv down sshd # sudo
sv restart sshd # sudo
sv status sshd
sv up sshd # sudo
void-installer # sudo
xbps-pkgdb -m hold paquet
xbps-pkgdb -m repolock paquet
xbps-pkgdb -m repounlock paquet
xbps-pkgdb -m unhold paquet
xbps-query -Rs nom_paquet
xbps-query -f paquet
xbps-query -l
xcheckrestart
xdbg bash
xdowngrade paquet.xbps
xlocate -S # sudo
xlocate fichier_dans_paquet
