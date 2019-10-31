#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-05 17:52:09
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-10-31 16:40:16

# Script to compile the upp library for output visualization
# $1: the path to the folder where the upp program should be installed

# define terminal colors
source ../../libs/terminal_color.sh

# Script to compile the optional upp package for postprocessing
cd ${HOME}/${1}

# Unpacking upp files
printf "${YELLOW}\\nUnpacking upp.tar files: ${NC}\\n"
tar xfv upp-3.1.tar.bz2

# Installing upp library
printf "${YELLOW}\\nInstaling upp: ${NC}\\n"
cd UPPV3.1
./configure

sed -r -i 's/NETCDFLIBS      =    -lnetcdff -lnetcdf/NETCDFLIBS      =    -lnetcdff -lnetcdf -lgomp/g' configure.upp

./compile >& ./compile.log

cd ..

printf "${LIGHT_BLUE}\\nFinished installing upp. ${NC}\\n"
