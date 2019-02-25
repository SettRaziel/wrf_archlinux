#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-01 20:09:17
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-02-25 20:23:25

# define terminal colors
source ../../libs/terminal_color.sh

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

# cleanup
rm WPSV${WPS_VERSION}.tar.gz

printf "${LIGHT_BLUE}\nFinished installing wps. ${NC}\n"
