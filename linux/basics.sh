#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-02-16 19:47:48
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-02-20 09:42:24

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
cd ~

# Fortran compiler
yaourt -S gcc-fortran
yaourt -S tcsh
yaourt -S openmpi
sudo pacman -S mpich
