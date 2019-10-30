#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-02-16 19:47:48
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-10-30 21:49:29

# setting -e to abort on error
set -e

# define terminal colors
source ../../libs/terminal_color.sh

# Script to get the required basic packages after installing the base system

# Start from home directory
cd ${HOME}

sudo pacman -Sy --needed make pkg-config fakeroot

printf "${YELLOW}Installing yay as package helper... \\n${NC}"
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
yay -S --needed tcsh time curl wget   # required packages
