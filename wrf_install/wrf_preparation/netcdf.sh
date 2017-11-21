#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-02-16 21:06:12
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-11-21 21:35:28

# installation of the netcdf package
# $1: path to the installation folder

# define terminal colors
RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHT_BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Script to compile the required netcdf package
cd ${HOME}/${1}

# Unpacking netcdf files
printf "${YELLOW}\nUnpacking netcdf.tar files: ${NC}\n"
tar xfv netcdf-${NETCDF_VERSION}.tar.gz

# Installing netcdf library
printf "${YELLOW}\nInstalling netcdf: ${NC}\n"
cd netcdf-${NETCDF_VERSION}
./configure --prefix=$DIR/netcdf --disable-dap --disable-netcdf-4 --disable-shared
make -j 2 &&  make install -j 2

cd ..

printf "${LIGHT_BLUE}\nFinished installing netcdf. ${NC}\n"
