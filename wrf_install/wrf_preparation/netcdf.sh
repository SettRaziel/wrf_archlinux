#!/bin/bash

# installation of the netcdf package
# ${1}: path to the installation folder

# setting -e to abort on error
set -e

# define terminal colors
. ../../libs/terminal_color.sh

# script to compile the required netcdf package
cd "${HOME}/${1}"

# installing the hdf 5 dependency
printf "%b\\nUnpacking hdf5.tar files: %b\\n" "${YELLOW}" "${NC}"
tar xfv "hdf5-${HDF_VERSION}.tar.gz"

# installing hdf5 library
printf "%b\\nInstalling hdf5: %b\\n" "${YELLOW}" "${NC}"
cd "hdf5-hdf5-${HDF_VERSION}"
LIBS="-lgcc_s" ./configure --enable-fortran --enable-fortran2003 --prefix="${DIR}/hdf5"
make -j 2 && make install -j 2

cd ..

export LDFLAGS="${LDFLAGS} -L${DIR}/hdf5/lib"
export CPPFLAGS="${CPPFLAGS} -I${DIR}/hdf5/include"

# unpacking netcdf files
printf "%b\\nUnpacking netcdf.tar files: %b\\n" "${YELLOW}" "${NC}"
tar xfv "netcdf-${NETCDF_VERSION}.tar.gz"

# installing netcdf library
printf "%b\\nInstalling netcdf: %b\\n" "${YELLOW}" "${NC}"
cd "netcdf-c-${NETCDF_VERSION}"
./configure --prefix="${DIR}/netcdf"
make -j 2 && make install -j 2

cd ..

# cleanup
rm "netcdf-${NETCDF_VERSION}.tar.gz"
rm -rf "netcdf-c-${NETCDF_VERSION}"
rm "hdf5-${HDF_VERSION}.tar.gz"
rm -rf "hdf5-hdf5-${HDF_VERSION}"

printf "%b\\nFinished installing netcdf. %b\\n" "${LIGHT_BLUE}" "${NC}"
