/etc/rc.d/sshd restart
co /etc/examples/doas.conf /etc
man afterboot
pkg_add -Uu
pkg_add -r pkglocatedb # doas
pkg_add -r vim # doas
pkg_info -Q vim
rcctl enable nfsd # doas
sysclean # doas
sysmerge # doas
syspatch # doas
sysupgrade # doas
syspatch # doas
sysmerge -d # doas
