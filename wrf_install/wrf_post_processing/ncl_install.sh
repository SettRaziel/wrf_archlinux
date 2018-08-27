#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-26 17:34:20
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2018-08-27 20:09:35

# Script to compile the ncar command language for output visualization
# $1: the path to the folder where the ncl program should be installed

# define terminal colors
RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHT_BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

NCL_NAME='ncl_ncarg-6.4.0-Debian8.6_64bit_nodap_gnu492.tar.gz'

# Script to extract the optional ncl package for postprocessing
# Path to the library folder
cd ${DIR}

# Unpacking ncl files
printf "${YELLOW}\nUnpacking ncl.tar files: ${NC}\n"
mkdir ncl
wget https://www.earthsystemgrid.org/dataset/ncl.640.nodap/file/${NCL_NAME}
tar -xzf ${NCL_NAME}

# cleanup tar
rm ${NCL_NAME}

# Installing additional library
printf "${YELLOW}\nInstaling additional libraries: ${NC}\n"
yaourt -S --needed fontconfig libxrender libxtst
# Installing optipng to optimize png output size
yaourt -S --needed optipng

printf "${LIGHT_BLUE}\nFinished ncl preparations. ${NC}\n"
