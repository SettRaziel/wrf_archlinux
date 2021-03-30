#!/bin/sh

# setting -e to abort on error
set -e

# define terminal colors
. ../libs/terminal_color.sh

# prepare Folders
SCRIPT_PATH=$(pwd)

cd "${HOME}" || exit 1
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

# installing packages for running the model
printf "%b\\nInstalling required model libraries: %b\\n" "${YELLOW}" "${NC}"
yay -S --noconfirm --needed pkgconfig
yay -S --noconfirm --needed tcsh wget curl findutils gcc-fortran
# dependency required with WRF 4.2.0
yay -S --noconfirm --needed libpciaccess libunwind

# installing required packages: 
# optipng for optimizing png size and unzip for loading high res coastlines
printf "%b\\nInstalling required packages for output visualization: %b\\n" "${YELLOW}" "${NC}"
yay -S --noconfirm --needed optipng unzip git

# installing packages to send emails
printf "%b\\nInstalling required mail libraries: %b\\n" "${YELLOW}" "${NC}"
yay -S --noconfirm --needed msmtp

# package clean up
sudo pacman --noconfirm -Rsn $(sudo pacman -Qdtq)

cd "${SCRIPT_PATH}" || exit 1
