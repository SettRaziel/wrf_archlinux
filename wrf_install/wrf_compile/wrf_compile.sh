#!/bin/bash

# setting -e to abort on error
set -e

# define terminal colors
. ../../libs/terminal_color.sh

# Script to compile the wrf model, after setting up all dependencies
# and paths
# ${1}: the path to the folder where the wrf should be installed

# storing current script path
SCRIPT_PATH=$(pwd)

# jump in folder and extract tar
cd "${HOME}/${1}"
printf "%b\\nUnpacking wrf.tar files: %b\\n" "${YELLOW}" "${NC}"
tar xfv "WRFV${WRF_VERSION}.tar.gz"

# build wrf
printf "%b\\nGetting submodules: %b\\n" "${YELLOW}" "${NC}"
cd "WRF-${WRF_VERSION}/phys/"
git clone https://github.com/NCAR/noahmp.git
cd "noahmp/"
git checkout "release-v${WRF_VERSION}-WRF"
cd "${HOME}/${1}/WRF-${WRF_VERSION}"

printf "%b\\nInstaling wrf: %b\\n" "${YELLOW}" "${NC}"
# link the cpp file to the correct folder or configure will fail in not finding it
if ! [ -L "/lib/cpp" ]; then
  sudo ln -s /bin/cpp /lib/cpp
fi
./configure
./clean

# add additional libraries
sed -r -i 's#-L\$\(WRF_SRC_ROOT_DIR\)\/external\/io_netcdf -lwrfio_nf#-L\$\(WRF_SRC_ROOT_DIR\)\/external\/io_netcdf -lnetcdf -ltirpc -lwrfio_nf#g' configure.wrf

./compile -j 1 em_real >& ./compile.log

# copy compiling log
cp compile.log "${SCRIPT_PATH}/../logs/wrf_compile.log" || exit 1

cd .. || exit 1

#clean up
rm "WRFV${WRF_VERSION}.tar.gz"
cd "${SCRIPT_PATH}"

printf "%b\\nFinished installing wrf. %b" "${LIGHT_BLUE}" "${NC}"
printf "%bCheck compile.log for details. %b\\n" "${LIGHT_BLUE}" "${NC}"
