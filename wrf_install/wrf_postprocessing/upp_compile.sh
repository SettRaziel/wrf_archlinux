#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-05 17:52:09
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-10-11 19:13:05

# Script to compile the upp library for output visualization
# ${1}: the path to the folder where the upp program should be installed

# define terminal colors
. ../../libs/terminal_color.sh

# Script to compile the optional upp package for postprocessing
cd "${HOME}/${1}" || exit 1

# Unpacking upp files
printf "%b\\nUnpacking upp.tar files: %b\\n" "${YELLOW}" "${NC}"
tar xfv upp-3.1.tar.bz2

# Installing upp library
printf "%b\\nInstaling upp: %b\\n" "${YELLOW}" "${NC}"
cd UPPV3.1 || exit 1
./configure

sed -r -i 's#NETCDFLIBS      =    -lnetcdff -lnetcdf#NETCDFLIBS      =    -lnetcdff -lnetcdf -lgomp#g' configure.upp

./compile >& ./compile.log

cd .. || exit 1

printf "%b\\nFinished installing upp. %b\\n" "${LIGHT_BLUE}" "${NC}"
