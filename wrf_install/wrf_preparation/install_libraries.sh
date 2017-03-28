#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-02-16 21:06:12
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-03-28 17:30:48

# define terminal colors
RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHT_BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

cd ~/$1

# Unpacking mpich files
printf "${YELLOW}\nUnpacking mpich.tar files: ${NC}\n"
tar xfv mpich-3.2.tar.gz

# Installing mpich library
printf "${YELLOW}\nInstaling mpich: ${NC}\n"
cd mpich-3.2
./configure --prefix=$DIR/mpich
make -j 2 && make install -j 2

cd ..

printf "${LIGHT_BLUE}\nFinished installing mpich. ${NC}\n"
printf "${YELLOW}Continuing in 5 seconds ... ${NC}"
sleep 5

# Unpacking zlib files
printf "${YELLOW}\nUnpacking zlib.tar files: ${NC}\n"
tar xfv zlib-1.2.11.tar.gz

# Installing zlib library
printf "${YELLOW}\nInstaling zlib: ${NC}\n"
cd zlib-1.2.11
./configure --prefix=$DIR/grib2
make -j 2 && make install -j 2

cd ..

printf "${LIGHT_BLUE}\nFinished installing zlib. ${NC}\n"
printf "${YELLOW}Continuing in 5 seconds ... ${NC}"
sleep 5

# Unpacking libpng files
printf "${YELLOW}\nUnpacking libpng.tar files: ${NC}\n"
tar xfv libpng-1.6.28.tar.gz

# Installing libpng library
printf "${YELLOW}\nInstaling libpng: ${NC}\n"
cd libpng-1.6.28
./configure --prefix=$DIR/grib2
make -j 2 && make install -j 2

cd ..

printf "${LIGHT_BLUE}\nFinished installing libpng. ${NC}\n"
printf "${YELLOW}Continuing in 5 seconds ... ${NC}"
sleep 5

# Unpacking jasper files
printf "${YELLOW}\nUnpacking jasper.tar files: ${NC}\n"
tar xfv jasper-1.900.1.tar.gz

# Installing jasper library
printf "${YELLOW}\nInstaling jasper: ${NC}\n"
cd jasper-1.900.1
./configure --prefix=$DIR/grib2
make -j 2 && make install -j 2

cd ..

printf "${LIGHT_BLUE}\nFinished installing jasper. ${NC}\n"
