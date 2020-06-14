#!/bin/sh
# @Author: Benjamin Held
# @Date:   2018-09-07 16:35:49
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-06-14 12:23:26

# define terminal colors
. ../libs/terminal_color.sh

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
yay -S --noconfirm --needed pkgconfig
yay -S --noconfirm --needed tcsh wget curl findutils gcc-fortran

# installing required packages: 
# optipng for optimizing png size and unzip for loading high res coastlines
printf "%b\\nInstalling required packages for output visualization: %b\\n" "${YELLOW}" "${NC}"
yay -S --noconfirm --needed optipng unzip

# installing packages to send emails
printf "%b\\nInstalling required mail libraries: %b\\n" "${YELLOW}" "${NC}"
yay -S --noconfirm --needed msmtp

# package clean up
sudo pacman --noconfirm -Rsn $(sudo pacman -Qdtq)

cd "${SCRIPT_PATH}" || exit 1
