#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-02-16 21:06:12
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-02-25 20:24:33

# installation of the netcdf package
# $1: path to the installation folder

# define terminal colors
source ../../libs/terminal_color.sh

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

# cleanup
rm netcdf-${NETCDF_VERSION}.tar.gz

printf "${LIGHT_BLUE}\nFinished installing netcdf. ${NC}\n"
