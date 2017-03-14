#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-05 17:52:09
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-03-14 21:14:29

# define terminal colors
RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHT_BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Script to compile the optional upp package for postprocessing
cd ~/$1

# Unpacking upp files
printf "${YELLOW}\nUnpacking upp.tar files: ${NC}\n"
tar xfv upp-3.1.tar.bz2

# Installing upp library
printf "${YELLOW}\nInstaling wps: ${NC}\n"
cd UPPV3.1
./configure

sed -r -i 's/NETCDFLIBS      =    -lnetcdff -lnetcdf/NETCDFLIBS      =    -lnetcdff -lnetcdf -lgomp/g' configure.upp

./compile >& ./compile.log

cd ..

printf "${LIGHT_BLUE}\nFinished installing upp. ${NC}\n"
