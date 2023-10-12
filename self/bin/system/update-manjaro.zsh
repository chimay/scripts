#!/usr/bin/env zsh

# clean cache

sudo pacman -Scc

# check site

w3m https://archlinux.org

# update mirrors

sudo pacman-mirrors --fasttrack

# refresh

sudo pacman -Syy

# new keys

sudo pacman -S archlinux-keyring

# update

sudo pacman -Syyu

# remove orphans

sudo pacman -Qdtq | sudo pacman -Rns -

# update files db

sudo pacman -Fy
#sudo pkfile -u
