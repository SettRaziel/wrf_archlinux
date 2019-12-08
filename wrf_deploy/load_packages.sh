#!/bin/sh
# @Author: Benjamin Held
# @Date:   2018-09-07 16:35:49
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-12-08 13:56:55

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
printf "${YELLOW}\\nInstalling required model libraries: ${NC}\\n"
yay -S --noconfirm --needed tcsh wget curl gcc-fortran

# installing required packages for running ncl
printf "${YELLOW}\\nInstalling additional ncl libraries: ${NC}\\n"
yay -S --noconfirm --needed fontconfig libxrender libxtst
# installing optipng to optimize png output size
yay -S --noconfirm --needed optipng

# ncl still requires libgfortran3.so and is no longer maintained, so we need gfortran 6.x.x
printf "${YELLOW}\\nInstalling gcc6-fortran for compatibility, that may take a while: ${NC}\\n"
yay -S --noconfirm --needed pkgconfig
yay -S --needed gcc6-fortran

# installing packages to send emails
printf "${YELLOW}\\nInstalling required mail libraries: ${NC}\\n"
yay -S --noconfirm --needed msmtp

# package clean up
sudo pacman --noconfirm -Rsn $(sudo pacman -Qdtq)

cd ${SCRIPT_PATH} || exit 1
