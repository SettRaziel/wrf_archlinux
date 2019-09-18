#!/bin/sh
# @Author: Benjamin Held
# @Date:   2018-09-07 16:35:49
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-09-18 09:39:18

# define terminal colors
source ../libs/terminal_color.sh

# prepare Folders
mkdir aur_packages
cd aur_packages

# getting yay and install if necessary
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm --needed
cd ..

# installing packages for running the model
printf "${YELLOW}\nInstalling required model libraries: ${NC}\n"
yay -S --noconfirm --needed tcsh wget curl

# installing required packages for running ncl
printf "${YELLOW}\nInstalling additional ncl libraries: ${NC}\n"
yay -S --noconfirm --needed fontconfig libxrender libxtst
# installing optipng to optimize png output size
yay -S --noconfirm --needed optipng

# installing packages to send emails
printf "${YELLOW}\nInstalling required mail libraries: ${NC}\n"
yay -S --noconfirm --needed msmtp
