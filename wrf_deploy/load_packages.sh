#!/bin/bash

# setting -e to abort on error
set -e

# define terminal colors
. ../libs/terminal_color.sh

# prepare Folders
SCRIPT_PATH=$(pwd)

cd "${HOME}"
# Prepare Folders
if ! [ -d "aur_packages" ]; then
  mkdir aur_packages
fi
cd aur_packages

# Getting yay
if ! [ -d "yay" ]; then
  git clone https://aur.archlinux.org/yay.git
fi
cd yay
git pull
makepkg -si --noconfirm --needed

# installing packages for running the model
printf "%b\\nInstalling required model libraries: %b\\n" "${YELLOW}" "${NC}"
yay -S --noconfirm --needed pkgconfig
yay -S --noconfirm --needed tcsh wget curl findutils gcc-fortran
# dependency required with WRF 4.2.0
yay -S --noconfirm --needed libpciaccess libunwind

printf "%bInstalling wrf required packages... \\n%b" "${YELLOW}" "${NC}"
yay -S --needed openmpi zlib libpng jasper

# installing required packages: 
# optipng for optimizing png size and unzip for loading high res coastlines
printf "%b\\nInstalling required packages for output visualization: %b\\n" "${YELLOW}" "${NC}"
yay -S --noconfirm --needed optipng unzip git

# installing packages to send emails
printf "%b\\nInstalling required mail libraries: %b\\n" "${YELLOW}" "${NC}"
yay -S --noconfirm --needed msmtp

cd "${SCRIPT_PATH}"
