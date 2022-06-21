#!/bin/bash

# setting -e to abort on error
set -e

# define terminal colors
. ../../libs/terminal_color.sh

# Script to compile the wps module, after setting up all dependencies
# and paths
# ${1}: the path to the folder where the wps should be installed

# storing current script path
SCRIPT_PATH=$(pwd)
cd "${HOME}/${1}"

# unpacking wps files
printf "%b\\nUnpacking wps.tar files: %b\\n" "${YELLOW}" "${NC}"
tar xfv "WPSV${WPS_VERSION}.tar.gz"

# installing wps
printf "%b\\nInstaling wps: %b\\n" "${YELLOW}" "${NC}"
cd "WPS-${WPS_VERSION}"
./configure --build-grib2-libs

# add additional libraries
sed -r -i 's#-L\$\(NETCDF\)\/lib -lnetcdff -lnetcdf#-L\$\(NETCDF\)\/lib -lnetcdff -lnetcdf -ltirpc -lgomp#g' configure.wps

./compile >& ./compile.log

# copy compiling log
cp compile.log "${SCRIPT_PATH}/../logs/wps_compile.log" || exit 1

cd ..

# cleanup
rm "WPSV${WPS_VERSION}.tar.gz"
cd "${SCRIPT_PATH}"

printf "%b\\nFinished installing wps. %b\\n" "${LIGHT_BLUE}" "${NC}"
