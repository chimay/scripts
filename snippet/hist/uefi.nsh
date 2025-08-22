#shellx64.efi
bcfg boot add 3 FS0:\EFI\refind\refind_x64.efi "rEFInd Boot Manager"
bcfg boot dump -b
bcfg boot dump -v
bcfg boot mv 04 00
bcfg boot rm 05
bootx64.efi
cd EFI
cd EFI/boot
cd boot
edit FS0:\EFI\refind\refind.conf
fs0:
help
help bcfg -v -b
load ntfs_x64.efi
ls
map -r
shellx64.efi
startup.nsh
