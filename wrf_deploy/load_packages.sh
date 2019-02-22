#!/bin/sh
# @Author: Benjamin Held
# @Date:   2018-09-07 16:35:49
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-02-22 17:58:05

# define terminal colors
source ../libs/terminal_color.sh

# Installing packages for running the model
printf "${YELLOW}\nInstalling required libraries: ${NC}\n"
yay -S --needed tcsh wget curl

# Installing required packages for running ncl
printf "${YELLOW}\nInstalling additional ncl libraries: ${NC}\n"
yay -S --needed fontconfig libxrender libxtst
# Installing optipng to optimize png output size
yay -S --needed optipng
