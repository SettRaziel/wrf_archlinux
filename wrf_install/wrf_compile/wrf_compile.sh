#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-02-18 15:49:25
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-10-24 13:20:51

# setting -e to abort on error
set -e

# define terminal colors
source ../../libs/terminal_color.sh

# Script to compile the wrf model, after setting up all dependencies
# and paths
# ${1}: the path to the folder where the wrf should be installed
# ${2}: the path to the folder where the wrf files has been unpacked

# storing current script path
SCRIPT_PATH=$(pwd)

# Jump in folder and extract tar
cd ${HOME}/${1}
printf "${YELLOW}\nUnpacking wrf.tar files: ${NC}\n"
tar xfv WRFV${WRF_VERSION}.tar.gz

# Build wrf
cd WRF
printf "${YELLOW}\nInstaling wrf: ${NC}\n"
# Change the path according to the used user; configure requires an absolute
# path here or it fails with an error
sudo ln -s /bin/cpp /lib/cpp
ln -s ${2}/WRF/frame/ ${2}/WRF/external/
./configure
./clean

# add additional libraries
sed -r -i 's/-L\$\(WRF_SRC_ROOT_DIR\)\/external\/io_netcdf -lwrfio_nf/-L\$\(WRF_SRC_ROOT_DIR\)\/external\/io_netcdf -ltirpc -lwrfio_nf/g' configure.wrf

./compile -j 1 em_real >& ./compile.log

# copy compiling log
cp compile.log ${SCRIPT_PATH}/../logs

cd ..

#clean up
rm WRFV${WRF_VERSION}.tar.gz
cd ${SCRIPT_PATH}

printf "${LIGHT_BLUE}\nFinished installing wrf. ${NC}"
printf "${LIGHT_BLUE}Check compile.log for details. ${NC}\n"
