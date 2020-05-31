#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-02-16 21:06:12
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-04-30 17:16:36

# installation of the netcdf package
# ${1}: path to the installation folder

# setting -e to abort on error
set -e

# define terminal colors
. ../../libs/terminal_color.sh

# Script to compile the required netcdf package
cd "${HOME}/${1}" || exit 1

# installing the hdf 5 dependency
printf "%b\\nUnpacking hdf5.tar files: %b\\n" "${YELLOW}" "${NC}"
tar xfv "hdf5-${HDF_VERSION}.0.tar.gz"

# Installing hdf5 library
printf "%b\\nInstalling hdf5: %b\\n" "${YELLOW}" "${NC}"
cd "hdf5-${HDF_VERSION}.0" || exit 1
env LIBS="-lgcc_s" ./configure --enable-fortran --enable-fortran2003 --prefix="${DIR}/hdf5"
make -j 2 && make install -j 2

cd .. || exit 1

export LDFLAGS="${LDFLAGS} -L${DIR}/hdf5/lib"
export CPPFLAGS="${CPPFLAGS} -I${DIR}/hdf5/include"

# Unpacking netcdf files
printf "%b\\nUnpacking netcdf.tar files: %b\\n" "${YELLOW}" "${NC}"
tar xfv "netcdf-${NETCDF_VERSION}.tar.gz"

# Installing netcdf library
printf "%b\\nInstalling netcdf: %b\\n" "${YELLOW}" "${NC}"
cd "netcdf-c-${NETCDF_VERSION}"
./configure --prefix="${DIR}/netcdf" 
make -j 2 &&  make install -j 2

cd .. || exit 1

# cleanup
rm "netcdf-${NETCDF_VERSION}.tar.gz"
rm "hdf5-${HDF_VERSION}.0.tar.gz"

printf "%b\\nFinished installing netcdf. %b\\n" "${LIGHT_BLUE}" "${NC}"
