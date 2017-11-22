#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-01 20:09:17
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-11-22 18:55:02

# define terminal colors
RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHT_BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Script to compile the wps module, after setting up all dependencies
# and paths
# $1: the path to the folder where the wps should be installed

# Script to compile the required netcdf package
cd ${HOME}/${1}

# Unpacking wps files
printf "${YELLOW}\nUnpacking wps.tar files: ${NC}\n"
tar xfv WPSV${WPS_VERSION}.tar.gz

# Installing wps
printf "${YELLOW}\nInstaling wps: ${NC}\n"
cd WPS
./configure

sed -r -i 's/-L\$\(NETCDF\)\/lib -lnetcdff -lnetcdf/-L\$\(NETCDF\)\/lib -lnetcdff -lnetcdf -lgomp/g' configure.wps

./compile >& ./compile.log

cd ..

printf "${LIGHT_BLUE}\nFinished installing wps. ${NC}\n"
