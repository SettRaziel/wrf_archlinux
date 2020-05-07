#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-02-16 19:47:48
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-05-07 17:55:55

# setting -e to abort on error
set -e

# define terminal colors
. ../../libs/terminal_color.sh

# Script to get the required basic packages after installing the base system

# Start from home directory
cd "${HOME}" || exit 1

sudo pacman -Sy --needed make pkg-config fakeroot m4

printf "%bInstalling yay as package helper... \\n%b" "${YELLOW}" "${NC}"
# Prepare git package
sudo pacman -S --needed git

# Prepare Folders
if ! [ -d "aur_packages" ]; then
  mkdir aur_packages
fi
cd aur_packages || exit 1

# Getting yay
if ! [ -d "yay" ]; then
  git clone https://aur.archlinux.org/yay.git
fi
cd yay || exit 1
git pull
makepkg -si --noconfirm --needed

printf "%bInstalling basic packages... \\n%b" "${YELLOW}" "${NC}"
# Installing required packages
yay -S --needed tcsh time curl wget gcc-fortran   # required packages
