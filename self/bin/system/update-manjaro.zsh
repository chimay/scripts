#!/usr/bin/env zsh

# clean cache

sudo pacman -Scc

# check site

w3m https://archlinux.org

# update mirrors

#sudo pacman-mirrors --fasttrack
sudo pacman-mirrors --country Germany --timeout 5

# refresh

sudo pacman -Syy

# new keys

# the manjaro pacman should to it by itself
#sudo pacman -S manjaro-keyring

# update

sudo pacman -Syyu

# remove orphans

sudo pacman -Qdtq | sudo pacman -Rns -

# update files db

sudo pacman -Fy
#sudo pkfile -u
