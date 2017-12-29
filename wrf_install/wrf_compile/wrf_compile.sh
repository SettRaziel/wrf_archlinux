#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-02-18 15:49:25
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-12-29 22:05:09

# define terminal colors
RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHT_BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Script to compile the wrf model, after setting up all dependencies
# and paths
# $1: the path to the folder where the wrf should be installed
# $2: the path to the folder where the wrf files has been unpacked

# Jump in folder and extract tar
cd ${HOME}/${1}
printf "${YELLOW}\nUnpacking wrf.tar files: ${NC}\n"
tar xfv WRFV${WRF_VERSION}.tar.gz

# Build wrf
cd WRFV3
printf "${YELLOW}\nInstaling wrf: ${NC}\n"
# Change the path according to the used user; configure requires an absolute
# path here or it fails with an error
sudo ln -s /bin/cpp /lib/cpp
ln -s ${2}/WRFV3/frame/ ${2}/WRFV3/external/
./configure
./clean
./compile -j 1 em_real >& ./compile.log

cd ..

#clean up
rm WRFV${WRF_VERSION}.tar.gz

printf "${LIGHT_BLUE}\nFinished installing wrf. ${NC}"
printf "${LIGHT_BLUE}Check compile.log for details. ${NC}\n"
