#!/bin/bash

# Script to compile the required libraries
# ${1}: path to the installation folder

# setting -e to abort on error
set -e

# define terminal colors
. ../../libs/terminal_color.sh

# move to the installation folder
cd "${HOME}/${1}" || exit 1

# unpacking mpich files
printf "%b\\nUnpacking mpich.tar files: %b\\n" "${YELLOW}" "${NC}"
tar xfv "mpich-${MPI_VERSION}.tar.gz"

# installing mpich library
printf "%b\\nInstalling mpich: %b\\n" "${YELLOW}" "${NC}"
cd "mpich-${MPI_VERSION}" || exit 1
./configure --prefix="${DIR}/mpich"
make -j 2 && make install -j 2

cd .. || exit 1

printf "%b\\nFinished installing mpich. %b\\n" "${LIGHT_BLUE}" "${NC}"
printf "%bContinuing in 5 seconds ... %b" "${YELLOW}" "${NC}"
sleep 5

# unpacking zlib files
printf "%b\\nUnpacking zlib.tar files: %b\\n" "${YELLOW}" "${NC}"
tar xfv "zlib-${ZLIB_VERSION}.tar.gz"

# installing zlib library
printf "%b\\nInstalling zlib: %b\\n" "${YELLOW}" "${NC}"
cd "zlib-${ZLIB_VERSION}"
./configure --prefix="${DIR}/grib2"
make -j 2 && make install -j 2

cd .. || exit 1

printf "%b\\nFinished installing zlib. %b\\n" "${LIGHT_BLUE}" "${NC}"
printf "%bContinuing in 5 seconds ... %b" "${YELLOW}" "${NC}"
sleep 5

# unpacking libpng files
printf "%b\\nUnpacking libpng.tar files: %b\\n" "${YELLOW}" "${NC}"
tar xfv "libpng-${LIBPNG_VERSION}.tar.gz"

# installing libpng library
printf "%b\\nInstalling libpng: %b\\n" "${YELLOW}" "${NC}"
cd "libpng-${LIBPNG_VERSION}" || exit 1
./configure --prefix="${DIR}/grib2"
make -j 2 && make install -j 2

cd .. || exit 1

printf "%b\\nFinished installing libpng. %b\\n" "${LIGHT_BLUE}" "${NC}"
printf "%bContinuing in 5 seconds ... %b" "${YELLOW}" "${NC}"
sleep 5

# unpacking jasper files
printf "%b\\nUnpacking jasper.tar files: %b\\n" "${YELLOW}" "${NC}"
tar xfv "jasper-${JASPER_VERSION}.tar.gz"

# installing jasper library
printf "%b\\nInstalling jasper: %b\\n" "${YELLOW}" "${NC}"
cd "jasper-${JASPER_VERSION}" || exit 1
./configure --prefix="${DIR}/grib2"
make -j 2 && make install -j 2

cd .. || exit 1

printf "%b\\nFinished installing jasper. %b\\n" "${LIGHT_BLUE}" "${NC}"

# cleanup
rm "mpich-${MPI_VERSION}.tar.gz"
rm "zlib-${ZLIB_VERSION}.tar.gz"
rm "libpng-${LIBPNG_VERSION}.tar.gz"
rm "jasper-${JASPER_VERSION}.tar.gz"
