#!/bin/sh
# @Author: Benjamin Held
# @Date:   2018-09-07 16:35:49
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2018-11-11 12:01:03

# Installing packages for running the model
yaourt -S --needed tcsh wget curl

# Installing required packages for running ncl
printf "${YELLOW}\nInstalling additional libraries: ${NC}\n"
yaourt -S --needed fontconfig libxrender libxtst
# Installing optipng to optimize png output size
yaourt -S --needed optipng
