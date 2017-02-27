#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-02-16 19:47:48
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-02-27 19:26:16

# Script to get the required basic packages after installing the base system

# Start from home directory
cd ~

# Prepare git package
sudo pacman -S git

# Prepare Folders
mkdir aur_packages
cd aur_packages

# Getting package query
git clone https://aur.archlinux.org/package-query.git
cd package-query
makepkg -si
cd ..

# Getting yaourt
git clone https://aur.archlinux.org/yaourt.git
cd yaourt
makepkg -si
cd ~/shared/wrf/scripts/wrf_non_arch

# Installing required packages
yaourt -S gcc-fortran
yaourt -S tcsh
yaourt -S openmpi
yaourt -S time
