#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-02-18 15:39:54
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-12-06 18:40:54

# Script to compile the required netcdf-fortran package
# ${1}: path to the installation folder

# setting -e to abort on error
set -e

# define terminal colors
source ../../libs/terminal_color.sh

# Jump in folder and extract tar
cd "${HOME}/${1}" || exit 1
printf "${YELLOW}\\nUnpacking netcdf-fortran.tar files: ${NC}\\n"
tar xfv "netcdf-fortran-${NETCDF_FORTRAN_VERSION}.tar.gz"

# Build netcdf-fortran bindings
cd "netcdf-fortran-${NETCDF_FORTRAN_VERSION}"
# Change the path according to the used user; configure requires an absolute
# path here or it fails with an error
./configure --prefix="${NETCDF}" 
make -j 2 && make -j 2 install

cd .. || exit 1

# clean up
rm "netcdf-fortran-${NETCDF_FORTRAN_VERSION}.tar.gz"

printf "${LIGHT_BLUE}\\nFinished installing netcdf fortran bindings. ${NC}\\n"
