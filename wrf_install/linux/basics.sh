#!/bin/bash

# setting -e to abort on error
set -e

# define terminal colors
. ../../libs/terminal_color.sh

# Script to get the required basic packages after installing the base system

# start from home directory
cd "${HOME}" || exit 1

sudo pacman -Sy --needed make pkg-config fakeroot m4

printf "%bInstalling yay as package helper... \\n%b" "${YELLOW}" "${NC}"
# prepare git package
sudo pacman -S --needed git

# prepare Folders
if ! [ -d "aur_packages" ]; then
  mkdir aur_packages
fi
cd aur_packages || exit 1

# getting yay
if ! [ -d "yay" ]; then
  git clone https://aur.archlinux.org/yay.git
fi
cd yay || exit 1
git pull
makepkg -si --noconfirm --needed

printf "%bInstalling basic packages... \\n%b" "${YELLOW}" "${NC}"
# installing required packages
yay -S --needed tcsh time curl wget gcc-fortran
