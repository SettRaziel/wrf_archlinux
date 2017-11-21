#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-02-18 15:39:54
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-11-21 21:35:20

# Script to compile the required netcdf-fortran package
# $1: path to the installation folder

# define terminal colors
RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHT_BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Jump in folder and extract tar
cd ${HOME}/${1}
printf "${YELLOW}\nUnpacking netcdf-fortran.tar files: ${NC}\n"
tar xfv netcdf-fortran-${NETCDF_FORTRAN_VERSION}.tar.gz

# Build netcdf-fortran bindings
cd netcdf-fortran-${NETCDF_FORTRAN_VERSION}
# Change the path according to the used user; configure requires an absolute
# path here or it fails with an error
CPPFLAGS="-I$DIR/netcdf/include" ./configure --prefix=$NETCDF --disable-shared
make -j 2 && make -j 2 install

cd ..

printf "${LIGHT_BLUE}\nFinished installing netcdf fortran bindings. ${NC}\n"
