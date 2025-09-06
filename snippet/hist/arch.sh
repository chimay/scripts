#sudo mount -t vfat -o loop ~filesys/fuse/Partition1 ~/image.iso/mnt
#vdfuse -f ~/image.iso/ghostbsd-efi.vdi ~filesys/fuse
./install --all --key-bindings --completion --update-rc
CC=/usr/bin/gcc pip install --user --upgrade pip
GTK_THEME=Adwaita:dark yad --about
MANPAGER="nvim -c 'set ft=man' -u NORC -" h man
VBoxManage controlvm freebsd-efi acpipowerbutton
VBoxManage controlvm freebsd-efi poweroff
VBoxManage startvm freebsd-efi
adig archlinux.org
alacritty -e bash -c "cat ~/log/clock.log ; read -p 'press enter to continue ...'"
alarm-sensor.zsh +75 ++82 -30 7
alias G '^[a-z]=' L
archlinux-java fix
archlinux-java help
archlinux-java set java-8-openjdk # sudo
archlinux-java status
aria2c -x 2 some-url
aria2c mirrors-urls
avahi-browse --all --ignore-local --resolve --terminate
avahi-discover
avahi-resolve-host-name mandala.local
blkid # sudo
borg extract ~/backup/borg::taijitu-2023-08-25T20:10:22.264263
borg list ~/backup/borg
borg mount ~/backup/borg::taijitu-2023-08-25T20:10:22.264263 ~/backup/mnt
borg umount ~/backup/mnt
borgmatic create --verbosity 1 --list --stats
borgmatic init --encryption repokey
borgmatic mount --repository usb-key --archive latest --mount-point ~/backup/mnt
borgmatic umount --mount-point ~/backup/mnt
cat /dev/sda | ssh remote-host 'cat > /dev/sda'
chanson=local && mpc -f "%file%"
chattr +i /etc/resolv.conf
cle=agent ; eval $(ssh-agent)
cle=change-pass ; ssh-keygen -p -f ~config/crypte/ssh/github/id_rsa_github
cle=decharge ; ssh-add -d ~config/cmdline/ssh/github/id_rsa_github
cle=gen ; ssh-keygen -t rsa -b 4096 -f ~/racine/config/cmdline/ssh/github/id_rsa_github_configuration
cle=github ; ssh-add ~config/cmdline/ssh/github/id_rsa_github
cle=liste ; ssh-add -l
cle=ssh-local ; ssh-add ~/racine/config/cmdline/ssh/$HOST/id_rsa
clocher=0 ; echo $clocher >! ~run/clock/clocher.etat ; cat ~run/clock/clocher.etat
clone=tmux-tpm ; git clone https://github.com/tmux-plugins/tpm
connmanctl
convert *paques*.png p2a-paques.pdf
coredumpctl info nvim
cp=derniers ; cp **/*(.m-7) /media/cleusb/syncron
cpu=ls-modules ; ls /usr/lib/modules/$(uname -r)/kernel/drivers/cpufreq/
cpu=max-freq ; sudo cpupower frequency-set -u 1300MHz
cpu_epb=12 ; sudo cpupower set -b $cpu_epb
cpu_epb=12 ; sudo echo $cpu_epb | sudo tee /sys/devices/system/cpu/cpu*/power/energy_perf_bias
cups=accept ; cupsaccept Officejet_5740
cups=add-printer ; lpadmin -E -p Officejet_5740 -v 'usb://HP/Officejet%205740%20series?serial=TH55U4Y0B905ZF&interface=1' -m 'drv:///hp/hpcups.drv/hp-officejet_5740_series.ppd'
cups=connected ; lpinfo -v
cups=enable ; cupsenable Officejet_5740
cups=modeles ; lpinfo -m L
curl 'http://www.central-fixation.com/perfect-sight-without-glasses/chapter-[1-32].php' -o 'chapter-#1.php'
dbus-run-session
dconf=dump ; dconf dump /com/gexperts/Tilix/ > ~config/terminal/tilix.dconf
dconf=load ; dconf load /com/gexperts/Tilix/ < ~config/terminal/tilix.dconf
dd status=progress if=/dev/sda | ssh remote-host 'dd of=/dev/sda'
demonte=cleusb ; udevil umount /dev/sdb1
demonte=diskext-sdb1 ; udevil umount /dev/sdb1
demonte=liseuse ; udevil umount /dev/sdb
demonte=photo ; udevil umount /dev/sdb1
demonte=sdb1 ; udevil umount /dev/sdb1
df=1 ; df G 'Sys\|sda\|sdb\|sdc\|sdd\|user_name'
diff -e un deux >! patch.ed
distrobox create --root --name debian --image debian
distrobox enter --root debian -- /bin/bash # sans le -- /bin/bash, les programmes gui ne fonctionnent pas
distrobox enter --root fedora -- /bin/bash # sans le -- /bin/bash, les programmes gui ne fonctionnent pas
distrobox list --root
distrobox rm --root debian
distrobox stop --root debian
dmenu=invisible ; dmenu -nb "#000000" -nf "#000000" -p "sudo password" <&-
doc=git ; m ~infoman/unix/version/progit.txt
doc=i3 ; w /usr/share/doc/i3/userguide.html
doc=mpv ; m /usr/share/doc/mpv/input.conf
doc=neomutt ; w /usr/share/doc/neomutt/manual.html
doc=rofi-script-modi ; m ~infoman/unix/utils/rofi-script-modi.txt
drill archlinux.org
ed=diff ; diff --ed un deux >! script.ed
ed=script ; (cat script.ed && echo w) | ed un
efibootmgr -b 05 -B # sudo, delete boot entry
efibootmgr -c -d /dev/sda -p 1 -L "Gentoo" -l '\efi\boot\bootx64.efi' # sudo, create boot entry
efibootmgr -v
emacs=byte-comp-dir ; emacs --batch --eval '(byte-recompile-directory "~/racine/plugin/manager/el-get/mtorus-user_name")'
faillock --user user_name --reset
fallocate -l 1G example.txt
feh=wallpaper ; feh --bg-max ~wallpaper/artisan/A-intoTheVoid.jpg
file --mime-type Bonhomme_hiver_2018.docx
find ~/photo -type f -links +1 L
find ~/photo -type f -printf '%n %p\n' | awk '$1 > 1 {$1="";print}'
find ~/photo -type f \! -links 1 L
firmware=dmesg ; sudo dmesg | grep -i firmware
fondecran=1 ; killall fond-ecran.zsh ; sleep 1 ; fond-ecran.zsh 12 120 ~/graphix/list/wallpaper.gen >>! ~/log/fond-ecran.log &!
fondecran=1 ; pkill fond-ecran.zsh ; sleep 1 ; fond-ecran.zsh 12 84 ~/graphix/list/wallpaper.gen >>! ~/log/fond-ecran.log &!
fossil addremove
fossil all
fossil changes
fossil ci -m "Importation initiale"
fossil close
fossil he
fossil init ~repo/central/fossil/plain
fossil log
fossil open ~repo/central/fossil/plain
fossil set ignore-glob
fossil set ignore-glob 'RCS,CVS,.git,.hg,.bzr,_darcs,tags,TAGS,GTAGS,GRTAGS,GPATH,ID,gtags.filesys' --global
fossil status
fossil timeline
fscheck=ext4 ; sudo fsck.ext4 -fvy /dev/sdc1
fzf=pipe ; var=$(e * | fzf -m --reverse --cycle --color=bw)
gem install neocities
gem update
git=checkout ; git checkout adc060c dirs-quigonjinn
git=clone-using-ssh ; git clone 'ssh://git@github.com/user_name/nb'
git=commit ; git add -A ; git commit
git=compresse ; git gc
git=doc ; m ~infoman/unix/version/progit.txt
git=filtre-fichier ; git filter-branch --index-filter 'git rm --cached --ignore-unmatch redshift.conf'
git=link-remote-branch ; git push --set-upstream codeberg master
git=push ; git push -u origin master
git=push-force ; git push --force codeberg
git=push-force-with-lease ; git push --force-with-lease codeberg
git=push-u ; git push -u origin master
git=rebase ; git rebase -i HEAD~4
git=remote-add-codeberg ; git remote add codeberg ssh://git@codeberg.org/user_name/pages.git
git=remote-add-github ; git remote add origin git@github.com:user_name/configuration.git
git=remote-add-gitlab git remote add origin git@gitlab.com:user_name/equa6on.git
git=remote-show ; git remote show origin
git=remote-show-url ; git remote get-url origin
git=reset ; git fetch --all && git reset --hard origin/master
git=set-default-remote ; git push --set-upstream codeberg master
git=set-default-remote-codeberg ; git push -u codeberg --all
git_rm_file=file ; git filter-repo --path-match $git_rm_file --invert-paths
gopher=1 ; lynx gopher://gopher.floodgap.com/1/world/
gpg --edit-key user_name@mail_server.com
gpg --list-keys
gpg --list-secret-keys
gpg --list-sigs
gpg --recv-keys --keyserver hkp://pgp.mit.edu 1EB2638FF56C0C53
gpg -d flower-4-petals.ggb.gpg > flower-4-petals.ggb
gpg -e flower-4-petals.ggb
grep=qute-history ; =grep url qutebrowser.history | sort | uniq | sed 's/     url = //' >! ~/.local/share/qutebrowser/history
grep_module=btrfs ; zgrep -i $grep_module /proc/config.gz
groff -ms -D utf8 -T pdf groff.ms >! groff.pdf
gsettings get org.gnome.desktop.interface gtk-theme
gv '^(\*|\*\*) ' *.org
handlr set x-scheme-handler/http org.qutebrowser.qutebrowser.desktop
hardlink -n -v ~/photo/numerique
hardlink -v ~/photo >&! ~/log/hardlink.log &
hardlink -vv /mnt/sda7/user_name/photo/numerique
hsetroot -fill ~/graphix/wallpaper/multics/multics-logo-rouge.jpg
i3-msg '[class="qutebrowser"] focus'
i3-msg -t get_tree
i3=get_workspaces ; i3-msg -t get_workspaces
i3=log-dump ; i3-dump-log L
i3=log-enable ; i3-msg "debuglog on ; shmlog on ; reload"
image=compresse ; img-compresse.zsh 2048 .
image=gray_to_black_and_white ; convert -type GrayScale -depth 1 IMG_20201112_091222.jpg vakantie.jpg
image=grid ; montage *.jpg -mode concatenate -tile 2x2 -page A4 -geometry +20+20 out.pdf
image=grille ; magick montage IMG* -geometry 450x450+2+2 montage.jpg
image=grille ; montage -tile 2x2 160px-Méduse_Le_Bernin.jpg Okéanos-Mosaique-Petra-Jordanie.jpg narcisse.jpg nymphee.jpg montage.jpg
image=tri ; img-triParDate.zsh ~/photo/import ~/photo/numerique/archives
ionice -c 2 -n 7 ls
ionice -c 3 ls
ip addr
ip link set wlan0 up
joue=random-U ; y $(e ~aclassique/**/[P-Z]-* | shuf | head -n 1)
kitty=fonts ; kitty list-fonts
lesskey -o ~/racine/built/less/key-natif.out ~/racine/config/visu/less/key-natif
lignes=1 ; { date ; echo ; wc -l ~eclats2vers/grimoire/*.org ; echo ; wc -l ~site/backup/grimoire/*.org ; echo } >> lignes.log
linux=command_line ; cat /proc/cmdline
liste=infegalP-classique ; e ~/audio/Artistes/Classique/**/[P-Z]-*.* | shuf >! ~/racine/musica/list/infegal-P.m3u
log=firmware ; journalctl -kg 'loaded f'
log=grep ; sudo journalctl -g sleep
log=important ; sudo journalctl -r -b -0 -p 0..4
log=kernel ; journalctl -k
log=syslog ; journalctl SYSLOG_FACILITY=1
loginctl show-session
loginctl terminate-user 1000
lp=duplex-paysage ; lp -o number-up=2 -o Duplex=DuplexTumble
lpoptions
ls -l `find ~/photo -type f -links +1` L
lsblk
lscpu
lsmonte=1 ; monte && e '\n----\n' && monte G --color=never 'sda\|sdb\|sdc\|sdd\|user_name\|media'
lstune=1 ; ls-tune -l
mail=send ; mail -s "eclats de vers $(date +%Y-%m-%d)" -a ~archive/eclats2vers-`date +%Y-%m-%d`.tar.xz user_name@mail_server.com < ~common/mail/archive
mail=send ; mail -s "eclats de vers" -a ~site/backup/orgmode.tar.xz -r user_name@mail_server.be user_name@mail_server.com < ~common/mail/archive
mail=send ; mutt -a =gen-skeleton.zsh -s script -- user_name@mail_server.be < ~common/mail/archive
mail=smtp-queue ; sudo smtpctl show queue
make install PREFIX=/usr/local # sudo
midi=connect_list ; aconnect -l
midi=connect_list_in ; aconnect -i
midi=connect_list_out ; aconnect -o
midi=play_alsa ; aplaymidi -p 128 templates/chambre.midi
midi=play_fluid ; fluidsynth -a alsa -m alsa_seq -i /usr/share/soundfonts/FluidR3_GM.sf2 test.mid
midi=ports-list ; aplaymidi -l
midi=server_fluid ; fluidsynth -is -a pulseaudio -m alsa_seq -r 48000 /usr/share/soundfonts/FluidR3_GM.sf2
midi=server_timidity ; timidity -iA
midi=to_ogg ; fluidsynth  -nli -r 48000 -o synth.cpu-cores=2 -T oga -F test.ogg /usr/share/soundfonts/FluidR3_GM.sf2 test.mid
mkdir=run-media ; sudo mkdir -p /run/media/user_name
mkswap -U clear swapfile # sudo
monte=cleusb ; udevil mount /dev/sdb1 /media/cleusb
monte=diskext-sdb1 ; udevil mount /dev/sdb1 /media/diskext-sdb1
monte=liseuse ; udevil mount /dev/sdb /media/liseuse
monte=photo ; udevil mount /dev/sdb1 /media/photo
monte=sdb1 ; udevil mount /dev/sdb1 /run/media/user_name/sdb1
mount -t cifs //shari/export ~/mount/import/samba
mount -t vboxsf -o uid=1000,gid=100 virtualbox-share /mnt # guest virtualbox, sudo
mpd=start ; pgrep mpd || { rm -f ~/racine/music/mpd/pid ; mpd ~/racine/config/music/mpd.conf }
mplayer=album ; mplayer $(print -l * | sort -t - -k 2)
mplayer=played ; grep Playing ~/log/mplayer.log
mpliste=Detente ; droits-audio.zsh ; mpc --wait update ; mpc crop ; mpc load $mpliste ; mpc play
mpliste=Meditation ; droits-audio.zsh ; mpc --wait update ; mpc crop ; mpc load $mpliste ; mpc play
mpliste=Tout ; genere-liste-melangee.py 7 1 0 ~/racine/musica/list/$mpliste.gen ; mpc --wait update ; mpc crop ; mpc load $mpliste ; mpc play
mpv=fifo ; mpv --idle --input-file=~/racine/run/fifo/mpv &!
ssh -L local_addr:local_port:remote_addr:remote_port user@sshd_addr
ssh -L 8080:localhost:80 user@server
ssh -L localhost:8080:localhost:80 user@server
ssh -R remote_addr:remote_port:local_addr:local_port user@gateway_addr
ssh -R localhost:8080:localhost:80 user@server
mv orgmode.tar.xz ~archive/eclats2vers-`date +%Y-%m-%d`.tar.xz
nf ~pack/aged/* ; echo ; nf /media/cleusb/archive/*
nf ~pack/aged/* ; echo ; nf /media/cleusb/archive/*
nice -n 10 ls
nmcli device wifi
nmcli device wifi connect Proximus-Home-6EB5
nmcli device wifi list
nmtui
pacman -S --force ttf-dejavu # sudo
pacman=browse ; pacman -Slq | fzf --preview 'pacman -Si {}' --layout=reverse
pacman=browse_installed ; pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'
pacman=get-pkg ; pacman -Qqe > liste-paquets
pacman=orphans ; pacman -Qtdq
pacman=remove-orphans ; sudo pacman -Rns $(pacman -Qtdq)
pacman=set-pkg ; pacman -S --needed - < liste-paquets
pactl list sinks short
pactl set-sink-volume bluez_sink.00_1D_DF_81_D7_55 -10%
pass add sites/www.decathlon.be/user_name@mail_server.be
pass edit sites/www.decathlon.be/user_name@mail_server.be
pass init user_name@mail_server.com
pass otp -c totp/github.com/user_name
pass otp add totp/lemmy.ml/user_name
pass otp totp/github.com/user_name
pass otp uri -q totp/github.com/user_name
pass show -c repository/gitter
pass show artisan/soundcloud
pdbedit -L -v
pdftotext -layout *.pdf
perl=var-tube ; perl -e '$a=qx(cat tags | grep spir) ; print $a'
pgrep -af vim
pico2wave -l fr-FR -w cpu-tres-chaud.wav 'Attention, les processeurs ont très chaud.'
pip install --user --upgrade neovim
pip install --user --upgrade neovim-gui
pip install --user --upgrade pip
pip=requirements-install ; pip install -r ~index/pack/pip-requirements.txt
pip=requirements-write ; pip freeze --local > ~index/pack/pip-requirements.txt
pip=upgrade-packages ; pip-review --local --auto
pip=upgrade-venv ; python -m venv --upgrade ~/.pip
pk + virtualbox{,-host-modules-arch} net-tools vde2
pk rm gnome-{perl,vfs-perl} gnomecanvas-perl perl-{gnome2-wnck,goo-canvas,gtk2-imageview,gtk2-unique} shutter
pk rm plasma-workspace kuiserver plasma-nm plasma-vault powerdevil kdeplasma-addons khotkeys plasma-meta plasma-pa kmenuedit plasma-desktop
pssh -vi -H quigonjinn.local -H shari.local date
pssh -vi -h ~config/cmdline/ssh/hotes date
pulseaudio=start ; pulseaudio --start
pulseaudio=stop ; pulseaudio -k
pv /dev/sda | ssh remote-host 'cat > /dev/sda'
pynvim -f Monospace 11
qemu-img create -f qcow2 ~/virtual/archlinux.img 64G
qemu-img create -f qcow2 ~/virtual/freebsd.img 32G
qemu-img create -f qcow2 ~/virtual/freebsd.img 64G
qemu-img create -f qcow2 ~/virtual/trueos.img 64G
qemu-system-x86_64 -cdrom ~/image.iso/arch-anywhere-2.2.3-dual.iso -boot order=d -drive file=$HOME/virtual/archlinux.img,format=qcow2
qemu-system-x86_64 -cdrom ~/image.iso/arch-anywhere-2.2.3-dual.iso -boot order=d -drive file=~/virtual/archlinux.img,format=qcow2
qemu-system-x86_64 -m 1G -cdrom ~/image.iso/FreeBSD-11.0-RELEASE-amd64-disc1.iso -boot order=d -drive file=$HOME/virtual/freebsd.img,format=qcow2
qemu-system-x86_64 -m 1G -cdrom ~/image.iso/arch-anywhere-2.2.3-dual.iso -boot order=d -drive file=$HOME/virtual/archlinux.img,format=qcow2
qemu-system-x86_64 -m 2G -boot menu=on -usb -hdb /media/virtual/image.iso/TrueOS-Desktop-2016-10-28-x64-USB.img -drive file=/media/virtual/trueos.img,format=qcow2
qrencode -o toto.jpg coucou
qute=reddit ; gv $qute ~dotdir/qutebrowser/$HOST
reflector --latest 12 --sort rate --save /etc/pacman.d/mirrorlist # arch, sudo
renice -n 12 -p process_id
restic find -r /media/cleusb/restic -s latest unison
restic init -r sftp:user_name@shari.local:$HOME/backup/restic
restic init -r ~/backup/restic
restic mount ~/backup/mnt
restic restore -r /media/da0s1/restic latest --target ~
restic restore -r /media/da0s1/restic latest --target ~ --include ~/racine/self
restic snapshots -r /media/da0s1/restic -c
restic-backup.sh /media/cleusb/restic
restic-backup.sh sftp:user_name@shari.local:$HOME/backup/restic
rfkill unblock wifi
rm=yt ; rm -f *.(m4a|webm|mp4|flv|aif|opus)
rs ~/audio /media/cleusb
rs ~pack/aged/ /media/cleusb/archive
scp=tilde.institute ; scp book* Makefile user_name@tilde.institute:~
senseurs=1 && sudo sensors && sudo hddtemp /dev/sda
services=sockets ; sudo ss -tulpn | less
signal=i3blocks-mpd ; k -36 $(pid i3blocks)
signal=i3blocks-volume ; k -35 $(pid i3blocks)
smbclient -L shari
smbclient //shari/user_name
smbpasswd -a user_name # sudo
smbpasswd user_name # sudo
sn ~syncron/cleusb/ /media/cleusb/syncron
sox carillon-23-00{,-fade}.ogg fade h 0 -0 1.7
sql=qute-history ; sqlite3 -line ~/.local/share/qutebrowser/history.sqlite 'select * from history' >>! ~archive/qutebrowser.history
ssh -p 3022 user_name@localhost
ssh-copy-id -i ~/.ssh/id_rsa.pub tixu.local
ssh=bitbucket-info ; ssh git@bitbucket.org host_key_info
ssh=ctrl-c.club ; ssh user_name@ctrl-c.club
ssh=dao-efi ; ssh -p 2223 user_name@localhost
ssh=fingerprint ; ssh-keygen -lf ~/racine/config/crypte/ssh/taijitu/id_rsa
ssh=fingerprint_all ; for f in ~config/crypte/ssh/**/*.pub; do ssh-keygen -lf $f; done
ssh=laozu-efi ; rm ~/.ssh/known_hosts ; ssh -p 2223 user_name@localhost
ssh=livingcomputers ; ssh menu@tty.livingcomputers.org
ssh=new_comment ; ssh-keygen -c -f ~config/crypte/ssh/ctrl-c.club/id_rsa
ssh=tilde.club ; ssh user_name@tilde.club
ssh=tilde.institute ; ssh user_name@tilde.institute
ssh=virtual ; rm -f ~/.ssh/known_hosts ; ssh -p 3022 user_name@localhost
ssh=virtual-root ; rm -f ~/.ssh/known_hosts ; ssh -p 3022 root@localhost
sshfs=demonte ; fusermount -u ~/mount/import/sshfs
sshfs=laozu ; sshfs laozu.local:$HOME ~/mount/import/sshfs
sshfs=monte ; sshfs shari.local:$HOME ~/mount/import/sshfs
sshfs=quigonjinn ; sshfs quigonjinn.local:$HOME ~/mount/import/sshfs
sshfs=shari ; sshfs shari.local:$HOME ~/mount/import/sshfs
sshfs=tixu ; sshfs tixu.local:$HOME ~/mount/import/sshfs
su -
su -c id
su -l
su -s /bin/sh
sudo -e /etc/fstab
sudo -s
sudo -sE xterm
sudo blkid /dev/sda1
sudo fallocate -l 8G swapfile
sudo locale-gen
sudo vim /etc/locale.gen
sudo=unlock ; faillock --user david --reset
sync=cleusb ; sn ~syncron/cleusb/ /media/cleusb/syncron
sync=cleusb ; sn ~syncron/cleusb/ /media/cleusb/syncron
sync=diskext-sdb1 ; unison diskext $HOME /run/media/user_name/sdb1/user_name
sync=diskext-sdb4 ; unison diskext $HOME /run/media/user_name/sdb4/user_name
sync=laozu-auto ; unison remote $HOME ssh://user_name@laozu.local//$HOME
sync=laozu-force ; unison remote $HOME ssh://user_name@laozu.local//$HOME -force $HOME
sync=pack-essentiel ; sn -n ~pack/aged/*(/om[1]) /media/cleusb/archive
sync=quigonjinn-auto ; unison remote $HOME ssh://user_name@quigonjinn.local//$HOME
sync=tixu-auto ; unison remote $HOME ssh://user_name@tixu.local//$HOME
systemctl --user import-environment DISPLAY
systemctl enable nmb.service --now # sudo
systemctl enable smb.service --now # sudo
systemctl enable wsdd.service --now # sudo
systemctl list-timers
systemctl list-unit-filesys | grep enabled
systemctl status org.cups.cupsd.service
systemd=ntp-restart ; sudo systemctl stop ntpd.service ; sudo systemctl start ntpdate.service ; sudo systemctl start ntpd.service
systemd=pulseaudio-restart ; pulseaudio=restart ; systemctl --user restart pulseaudio
systemd=timer-mask ; sudo systemctl mask updatedb.timer
systemd=timesync ; sudo systemctl status systemd-timesyncd
systemd=user-active-tmux ; systemctl --user enable tmux
systemd=user-services-persistants ; sudo loginctl enable-linger user_name
t context delete important
telnet taijitu.local 22
term=info ; infocmp
timedatectl list-timezones
timedatectl set-ntp true
timedatectl show-timesync --all
timedatectl timesync-status
timeshift --list # sudo
tmux kill-session -t 0
tmux=start ; systemctl --user start tmux
tmux=stop ; systemctl --user start tmux
tmux=systemd ; systemd-run --user --scope tmux
toot activate user_name@bsd.cafe
toot auth
toot login
toot tui
touchpad=list-options ; xinput list-props 15
touchpad=tap ; xinput set-prop 15 289 1
tri=audio ; e ~/audio/**/0-*.* | shuf >! ~/racine/musica/list/triage.m3u
truncate -s 8G swapfile # sudo
ts -C
ts -D 0,1,3 sleep 10  # runs after jobs 0, 1 and 3
ts -K
ts -L label sleep 10
ts -S 7
ts -W 0,2,3 sleep 10  # to run this job, jobs 0, 2 and 3 need to finish well
ts -c 0
ts -d sleep 10  # does not care about exit code
ts -k 0
ts sleep 300
unlock=gnome-keyring-daemon ; gnome-keyring-daemon --unlock
unlock=gnome-secret-keyring ; unlock-gnome-keyring
update=1 ; teste-connexion.zsh && pk cln && sync && sleep 3 && pk sf && sleep 3 && w https://archlinux.org && pk ++
usermod -aG wheel,adm,sys,log,network,video,audio,power,lp,autologin user_name # sudo
uuid_part=/dev/sda2 ; sudo blkid -s UUID -o value $uuid_part
var=( ${(f)"$(< fichier )"} )
var=( ${(fu)"$(< fichier )"} )
verifie=sdb1 ; sudo fsck /dev/$verifie
vim=profile-as-arg ; vim +'profile start ~/log/vim-profile.log | profile func * | call wheel#disc#read_wheel () | profile stop'
vim=profile-startup ; vim --startuptime ~/log/vim-startuptime.log ~shell/alarm/Grenier
w 181.html | sed -n '/Yogani/,/The guru is in you/p' | festival --tts
w fundamental.php | festival --tts
w fundamental.php | text2wave | lame - ~/audio/festival/fundamental.mp3
wget-blog.zsh 1 vermaden.wordpress.com,vermaden.filesys.wordpress.com https://vermaden.wordpress.com/
wifi-menu
wifi_bluetooth=1 ; rfkill list
xdg-mime default org.qutebrowser.qutebrowser.desktop text/html
xdg-settings set default-web-browser org.qutebrowser.qutebrowser.desktop
xdg-settings set default-web-browser qutebrowser.desktop
xdg=filetype ; xdg-mime query filetype ~plain/alimen/courses.org
xdg=help-mime ; xdg-mime --help
xdg=open ; xdg-open alimen/courses.org
xdg=query ; xdg-mime query default text/plain
xdotool=keys ; xdotool search "qutebrowser" windowactivate --sync key --clearmodifiers o
xinput list
xinput list-props 15
xplanet -wait 300 -label -labelpos -15+50 -projection rectangular &
xplanet -wait 300 -projection rectangular &
xrdb=load ; xrdb -load ~/.Xresources
xrdb=merge ; xrdb -merge ~/.Xresources
xset +fp "$user_fonts_dir" && xset fp rehash
xterm -hold ls
xzgv **/*(om.)
zbarimg de71a55ef7d3eba4.png
zcat /var/lib/pacman/sync/* | awk 'f { print ; f = 0 } /%NAME%/{ f = 1 }' > ~index/pack/pacman.liste-packages
~source/neovim-qt && git pull && mkdir ./build && cd ./build && cmake .. && make
~source/unison-2.51.2 && make UISTYLE=text
