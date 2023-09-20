#! /usr/bin/env zsh

# vim: set conceallevel=0 :

repertoire=${1:-.}

description=${2:-"CD ROM"}

mkisofs -V "$description" -J -r -o image-cdrom.iso $repertoire

umount /dev/sr0

cdrecord dev=/dev/sr0 -checkdrive

cdrecord -v -sao dev=/dev/sr0 image-cdrom.iso
