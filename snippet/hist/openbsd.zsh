man afterboot
sysclean # doas
sysmerge # doas
syspatch # doas
sysupgrade # doas
pkg_add -r vim # doas
pkg_add -r pkglocatedb # doas
co /etc/examples/doas.conf /etc
pkg_info -Q vim
/etc/rc.d/sshd restart
