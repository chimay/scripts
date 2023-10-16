apt list --installed
apt-clone clone nom-source
apt-clone restore nom-source.apt-clone.tar.gz # sudo
apt=get-auto ; apt-mark showauto > liste-auto
apt=get-manual ; apt-mark showmanual > liste-manuel
apt=get-pkg ; apt-get update ; apt-get dist-upgrade ; dpkg --get-selections > liste-paquets
apt=set-auto ; xargs apt-mark auto < liste-auto # sudo
apt=set-manuel ; apt-mark manual $(cat liste-manuel) # sudo
apt=set-pkg ; apt-get update ; dselect update ; dselect upgrade ; dpkg --set-selections < liste-paquets ; dselect install # sudo
apt=set-pkg ; dpkg --set-selections < liste-paquets ; apt-get dselect-upgrade # sudo
apt=sync-available ; apt-cache dumpavail | dpkg --merge-avail
apt=sync-available ; apt-get install dctrl-tools ; sync-available
apt=sync-available-and-update ; dselect update
dpkg --set-selections < liste-paquets ; apt-get dselect-upgrade # sudo
dpkg-query -l # sudo
dpkg-reconfigure paquet # sudo
update-alternatives --display java # sudo
update-alternatives --list java # sudo
update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java # sudo
