#!/bin/sh
# @Author: Benjamin Held
# @Date:   2018-09-07 16:35:49
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-04-06 16:41:23

# define terminal colors
source ../libs/terminal_color.sh

# prepare Folders
SCRIPT_PATH=$(pwd)
mkdir "${HOME}/aur_packages"
cd "${HOME}/aur_packages" || exit 1

# getting yay and install if necessary
git clone https://aur.archlinux.org/yay.git
cd yay || exit 1
makepkg -si --noconfirm --needed
cd .. || exit 1

# installing packages for running the model
printf "%b\\nInstalling required model libraries: %b\\n" "${YELLOW}" "${NC}"
yay -S --noconfirm --needed tcsh wget curl findutils gcc-fortran

# installing required packages for running ncl
printf "%b\\nInstalling additional ncl libraries: %b\\n" "${YELLOW}" "${NC}"
yay -S --noconfirm --needed fontconfig libxrender libxtst
# installing optipng to optimize png output size
yay -S --noconfirm --needed optipng

# ncl still requires libgfortran3.so and is no longer maintained, so we need gfortran 6.x.x
printf "%b\\nInstalling gcc6-fortran for compatibility, that may take a while: %b\\n" "${YELLOW}" "${NC}"
yay -S --noconfirm --needed pkgconfig
yay -S --needed gcc6-fortran

# installing packages to send emails
printf "%b\\nInstalling required mail libraries: %b\\n" "${YELLOW}" "${NC}"
yay -S --noconfirm --needed msmtp

# package clean up
sudo pacman --noconfirm -Rsn $(sudo pacman -Qdtq)

cd "${SCRIPT_PATH}" || exit 1
