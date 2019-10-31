#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-02-16 21:06:12
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-10-31 16:42:06

# installation of the netcdf package
# ${1}: path to the installation folder

# setting -e to abort on error
set -e

# define terminal colors
source ../../libs/terminal_color.sh

# Script to compile the required netcdf package
cd ${HOME}/${1}

# installing the hdf 5 dependency
printf "${YELLOW}\\nUnpacking hdf5.tar files: ${NC}\\n"
tar xfv hdf5-${HDF_VERSION}.tar.gz

# Installing hdf5 library
printf "${YELLOW}\\nInstalling hdf5: ${NC}\\n"
cd hdf5-${HDF_VERSION}
setenv LIBS="-lgcc_s"
./configure --enable-fortran --enable-fortran2003 --prefix=${DIR}/hdf5
make -j 2 && make install -j 2

cd ..

export LDFLAGS="${LDFLAGS} -L${DIR}/hdf5/lib"
export CPPFLAGS="${CPPFLAGS} -I${DIR}/hdf5/include"

# Unpacking netcdf files
printf "${YELLOW}\\nUnpacking netcdf.tar files: ${NC}\\n"
tar xfv netcdf-${NETCDF_VERSION}.tar.gz

# Installing netcdf library
printf "${YELLOW}\\nInstalling netcdf: ${NC}\\n"
cd netcdf-${NETCDF_VERSION}
./configure --prefix=${DIR}/netcdf 
make -j 2 &&  make install -j 2

cd ..

# cleanup
rm netcdf-${NETCDF_VERSION}.tar.gz
rm hdf5-${HDF_VERSION}.tar.gz

printf "${LIGHT_BLUE}\\nFinished installing netcdf. ${NC}\\n"
