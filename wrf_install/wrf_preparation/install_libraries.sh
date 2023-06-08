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

# cleanup
rm "mpich-${MPI_VERSION}.tar.gz"
rm -rf "mpich-${MPI_VERSION}"
