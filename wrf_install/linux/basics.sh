#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-02-16 19:47:48
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-04-05 10:43:04

# setting -e to abort on error
set -e

# define terminal colors
source ../../libs/terminal_color.sh

# Script to get the required basic packages after installing the base system

# Start from home directory
cd "${HOME}" || exit 1

sudo pacman -Sy --needed make pkg-config fakeroot m4

printf "%bInstalling yay as package helper... \\n%b" "${YELLOW}" "${NC}"
# Prepare git package
sudo pacman -S --needed git

# Prepare Folders
mkdir aur_packages
cd aur_packages || exit 1

# Getting yay
git clone https://aur.archlinux.org/yay.git
cd yay || exit 1
makepkg -si --noconfirm --needed

printf "%bInstalling basic packages... \\n%b" "${YELLOW}" "${NC}"
# Installing required packages
yay -S --needed tcsh time curl wget gcc-fortran   # required packages
