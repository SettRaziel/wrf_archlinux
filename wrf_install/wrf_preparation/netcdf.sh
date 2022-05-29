#!/bin/bash

# installation of the netcdf package
# ${1}: path to the installation folder

# setting -e to abort on error
set -e

# define terminal colors
. ../../libs/terminal_color.sh

# script to compile the required netcdf package
cd "${HOME}/${1}" || exit 1

# installing the hdf 5 dependency
printf "%b\\nUnpacking hdf5.tar files: %b\\n" "${YELLOW}" "${NC}"
tar xfv "hdf5-${HDF_VERSION}.0.tar.gz"

# installing hdf5 library
printf "%b\\nInstalling hdf5: %b\\n" "${YELLOW}" "${NC}"
cd "hdf5-${HDF_VERSION}.0" || exit 1
LIBS="-lgcc_s" CC="mpicc" ./configure --enable-shared --enable-parallel --enable-fortran --enable-fortran2003 --prefix="${DIR}/hdf5"
make -j 2 && make install -j 2

cd .. || exit 1


# unpacking pnetcdf files
printf "%b\\nUnpacking pnetcdf.tar files: %b\\n" "${YELLOW}" "${NC}"
tar xfv "pnetcdf-${PNETCDF_VERSION}.tar.gz"

# installing pnetcdf library
printf "%b\\nInstalling pnetcdf: %b\\n" "${YELLOW}" "${NC}"
cd "pnetcdf-${PNETCDF_VERSION}"
CC="mpicc" ./configure --prefix="${DIR}/pnetcdf"
make -j 2 && make install -j 2

cd .. || exit 1

export LDFLAGS="${LDFLAGS} -L${DIR}/hdf5/lib -L${DIR}/pnetcdf/lib"
export CPPFLAGS="${CPPFLAGS} -I${DIR}/hdf5/include -I${DIR}/pnetcdf/include"

# unpacking netcdf files
printf "%b\\nUnpacking netcdf.tar files: %b\\n" "${YELLOW}" "${NC}"
tar xfv "netcdf-${NETCDF_VERSION}.tar.gz"

# installing netcdf library
printf "%b\\nInstalling netcdf: %b\\n" "${YELLOW}" "${NC}"
cd "netcdf-c-${NETCDF_VERSION}"
./configure --enable-pnetcdf --enable-shared --enable-parallel-tests --prefix="${DIR}/netcdf"
make -j 2 && make install -j 2

cd .. || exit 1

# cleanup
rm "netcdf-${NETCDF_VERSION}.tar.gz"
rm -rf "netcdf-c-${NETCDF_VERSION}"
rm "hdf5-${HDF_VERSION}.0.tar.gz"
rm -rf "hdf5-${HDF_VERSION}.0"
rm "pnetcdf-${PNETCDF_VERSION}.tar.gz"
rm -rf "pnetcdf-${PNETCDF_VERSION}"

printf "%b\\nFinished installing netcdf. %b\\n" "${LIGHT_BLUE}" "${NC}"
