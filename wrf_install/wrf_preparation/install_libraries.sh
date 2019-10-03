#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-02-16 21:06:12
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-06-17 20:09:01

# Script to compile the required libraries
# $1: path to the installation folder

# define terminal colors
source ../../libs/terminal_color.sh

# move to the installation folder
cd ${HOME}/${1}

# Unpacking mpich files
printf "${YELLOW}\nUnpacking mpich.tar files: ${NC}\n"
tar xfv mpich-${MPI_VERSION}.tar.gz

# Installing mpich library
printf "${YELLOW}\nInstalling mpich: ${NC}\n"
cd mpich-${MPI_VERSION}
./configure --prefix=${DIR}/mpich
make -j 2 && make install -j 2

cd ..

printf "${LIGHT_BLUE}\nFinished installing mpich. ${NC}\n"
printf "${YELLOW}Continuing in 5 seconds ... ${NC}"
sleep 5

# Unpacking zlib files
printf "${YELLOW}\nUnpacking zlib.tar files: ${NC}\n"
tar xfv zlib-${ZLIB_VERSION}.tar.gz

# Installing zlib library
printf "${YELLOW}\nInstalling zlib: ${NC}\n"
cd zlib-${ZLIB_VERSION}
./configure --prefix=${DIR}/grib2
make -j 2 && make install -j 2

cd ..

printf "${LIGHT_BLUE}\nFinished installing zlib. ${NC}\n"
printf "${YELLOW}Continuing in 5 seconds ... ${NC}"
sleep 5

# Unpacking libpng files
printf "${YELLOW}\nUnpacking libpng.tar files: ${NC}\n"
tar xfv libpng-${LIBPNG_VERSION}.tar.gz

# Installing libpng library
printf "${YELLOW}\nInstalling libpng: ${NC}\n"
cd libpng-${LIBPNG_VERSION}
./configure --prefix=${DIR}/grib2
make -j 2 && make install -j 2

cd ..

printf "${LIGHT_BLUE}\nFinished installing libpng. ${NC}\n"
printf "${YELLOW}Continuing in 5 seconds ... ${NC}"
sleep 5

# Unpacking jasper files
printf "${YELLOW}\nUnpacking jasper.tar files: ${NC}\n"
tar xfv jasper-${JASPER_VERSION}.tar.gz

# Installing jasper library
printf "${YELLOW}\nInstalling jasper: ${NC}\n"
cd jasper-${JASPER_VERSION}
./configure --prefix=${DIR}/grib2
make -j 2 && make install -j 2

cd ..

printf "${LIGHT_BLUE}\nFinished installing jasper. ${NC}\n"

# cleanup
rm mpich-${MPI_VERSION}.tar.gz
rm zlib-${ZLIB_VERSION}.tar.gz
rm libpng-${LIBPNG_VERSION}.tar.gz
rm jasper-${JASPER_VERSION}.tar.gz
