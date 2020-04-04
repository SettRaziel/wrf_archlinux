#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-01 20:09:17
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-04-04 16:05:40

# setting -e to abort on error
set -e

# define terminal colors
source ../../libs/terminal_color.sh

# Script to compile the wps module, after setting up all dependencies
# and paths
# ${1}: the path to the folder where the wps should be installed

# storing current script path
SCRIPT_PATH=$(pwd)

# Script to compile the required netcdf package
cd "${HOME}/${1}" || exit 1

# Unpacking wps files
printf "%b\\nUnpacking wps.tar files: %b\\n" "${YELLOW}" "${NC}"
tar xfv "WPSV${WPS_VERSION}.tar.gz"

# Installing wps
printf "%b\\nInstaling wps: %b\\n" "${YELLOW}" "${NC}"
cd "WPS-${WPS_VERSION}" || exit 1
./configure

# add additional libraries
sed -r -i 's/-L\$\(NETCDF\)\/lib -lnetcdff -lnetcdf/-L\$\(NETCDF\)\/lib -lnetcdff -lnetcdf -ltirpc -lgomp/g' configure.wps

./compile >& ./compile.log

# copy compiling log
cp compile.log "${SCRIPT_PATH}/../logs" || exit 1

cd .. || exit 1

# cleanup
rm "WPSV${WPS_VERSION}.tar.gz"
cd "${SCRIPT_PATH}" || exit 1

printf "%b\\nFinished installing wps. %b\\n" "${LIGHT_BLUE}" "${NC}"
