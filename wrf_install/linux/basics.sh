#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-02-16 19:47:48
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-02-14 18:20:53

# define terminal colors
RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHT_BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Script to get the required basic packages after installing the base system

# Start from home directory
cd ${HOME}

sudo pacman -Sy --needed make pkg-config fakeroot

printf "${YELLOW}Installing yay as package helper... \n${NC}"
# Prepare git package
sudo pacman -S --needed git

# Prepare Folders
mkdir aur_packages
cd aur_packages

# Getting yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

printf "${YELLOW}Installing basic packages... ${NC}"
# Installing required packages
yay -S --needed gcc-fortran			# fortran compiler
yay -S --needed tcsh time curl wget   # required packages
