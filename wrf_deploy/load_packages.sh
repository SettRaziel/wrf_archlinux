#!/bin/sh
# @Author: Benjamin Held
# @Date:   2018-09-07 16:35:49
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2018-09-15 15:57:16

# Installing packages for running the model
yaourt -S --needed tsch wget curl

# Installing required packages for running ncl
printf "${YELLOW}\nInstalling additional libraries: ${NC}\n"
yaourt -S --needed fontconfig libxrender libxtst
# Installing optipng to optimize png output size
yaourt -S --needed optipng
