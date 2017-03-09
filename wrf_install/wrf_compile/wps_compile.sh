#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-01 20:09:17
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-03-09 21:56:00

# define terminal colors
RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHT_BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Script to compile the required netcdf package
cd ~/$1

# Unpacking netcdf files
printf "${YELLOW}\nUnpacking wps.tar files: ${NC}\n"
tar xfv wps-3.8.1.tar.bz2

# Installing netcdf library
printf "${YELLOW}\nInstaling wps: ${NC}\n"
cd WPS
./configure

sed -r -i 's/-L\$\(NETCDF\)\/lib -lnetcdff -lnetcdf/-L\$\(NETCDF\)\/lib -lnetcdff -lnetcdf -lgomp/g' configure.wps

./compile >& ./compile.log

cd ..

printf "${LIGHT_BLUE}\nFinished installing wps. ${NC}\n"
