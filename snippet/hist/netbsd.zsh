audiocfg list
cat /etc/mk.conf
cpuctl list
dkctl /dev/dk0 getwedgeinfo
dkctl wd0 listwedges
gpt add -a 2m -l "EFI system" -t efi -s 128m wd0 # su
gpt add -a 2m -l NetBSD -t ffs -s 21g wd0 # su
gpt create wd0 # su
gpt show wd0 # su
ifconfig iwm0 up
make -V WRKSRC # pkgsrc
make clean # (su) pkgsrc
make configure # (su) pkgsrc
make deinstall # (su) pkgsrc
make distclean # (su) pkgsrc
make extract # (su) pkgsrc
make fetch # (su) pkgsrc
make install # (su) pkgsrc
make makesum # (su) pkgsrc
make mps # (su) pkgsrc
make package # (su) pkgsrc
make print-PLIST > PLIST # (su) pkgsrc
make show-var VARNAME=WRKSRC # pkgsrc
make stage-install # (su) pkgsrc
make update # (su) pkgsrc
man afterboot
mixerctl -av
mkpatches
modload ...
modstat
modunload ...
mount -t msdos /dev/dk0 /mnt # su, efi
netstat -rn
pkgin install pkg_developer
pkgvi file
sandboxctl
service dhcpcd restart # su
service mdnsd start # su
service network restart # su
service sshd start # su
service wpa_supplicant start # su
service xdm restart # su
sysctl hw.disknames
sysinst # su
url2pkg https://repo-url
vipw
wpa_cli scan
wpa_cli scan_results
wsconsctl
