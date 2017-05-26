#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-02-16 19:47:48
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-05-26 18:16:30

# define terminal colors
RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHT_BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Script to get the required basic packages after installing the base system

# Start from home directory
cd ${HOME}

printf "${YELLOW}Installing yaourt and its requirements... \n${NC}"
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

printf "${YELLOW}Installing basic packages... ${NC}"
# Installing required packages
yaourt -S gcc-fortran
yaourt -S tcsh
yaourt -S time
