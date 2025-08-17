startup.nsh
help
map -r
#shellx64.efi
help bcfg -v -b
bcfg boot dump -b
bcfg boot dump -v
bcfg boot add 3 FS0:\EFI\refind\refind_x64.efi "rEFInd Boot Manager"
bcfg boot mv 04 00
bcfg boot rm 05
fs0:
ls
shellx64.efi
cd EFI
cd boot
cd EFI/boot
edit FS0:\EFI\refind\refind.conf
bootx64.efi
