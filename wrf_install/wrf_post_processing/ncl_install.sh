#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-26 17:34:20
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-03-29 20:02:53

# define terminal colors
RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHT_BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Script to extract the optional ncl package for postprocessing
# Path to the library folder
cd ~/$1

# Unpacking ncl files
printf "${YELLOW}\nUnpacking ncl.tar files: ${NC}\n"
mkdir ncl
cd ncl
tar xfv ncl_ncarg-6.4.0-Debian8.6_64bit_gnu492.tar.gz

# Installing additional library
printf "${YELLOW}\nInstaling additional libraries: ${NC}\n"
yaourt -S fontconfig

printf "${LIGHT_BLUE}\nFinished ncl preparations. ${NC}\n"
