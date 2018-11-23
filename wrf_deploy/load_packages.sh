#!/bin/sh
# @Author: Benjamin Held
# @Date:   2018-09-07 16:35:49
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2018-11-24 00:08:50

# define terminal colors
RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHT_BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Installing packages for running the model
printf "${YELLOW}\nInstalling required libraries: ${NC}\n"
yaourt -S --needed tcsh wget curl

# Installing required packages for running ncl
printf "${YELLOW}\nInstalling additional ncl libraries: ${NC}\n"
yaourt -S --needed fontconfig libxrender libxtst
# Installing optipng to optimize png output size
yaourt -S --needed optipng
