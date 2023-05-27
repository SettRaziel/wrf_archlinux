#!/bin/bash

# setting -e to abort on error
set -e

# define terminal colors
. ../../libs/terminal_color.sh

# Script to get the required basic packages after installing the base system

# start from home directory
cd "${HOME}"

sudo pacman -Sy --needed make pkg-config fakeroot m4

printf "%bInstalling yay as package helper... \\n%b" "${YELLOW}" "${NC}"
# prepare git package
sudo pacman -S --needed git

# prepare Folders
if ! [ -d "aur_packages" ]; then
  mkdir aur_packages
fi
cd aur_packages

# getting yay
if ! [ -d "yay" ]; then
  git clone https://aur.archlinux.org/yay.git
fi
cd yay
git pull
makepkg -si --noconfirm --needed

# installing required packages
printf "%bInstalling basic packages... \\n%b" "${YELLOW}" "${NC}"
yay -S --needed tcsh time curl wget gcc-fortran

printf "%bInstalling wrf required packages... \\n%b" "${YELLOW}" "${NC}"
yay -S --needed zlib libpng jasper
