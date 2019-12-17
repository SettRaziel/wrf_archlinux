#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-02-19 13:25:49
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-12-17 18:55:43

# main installation script: start the installation of the wrf model on a
# minimal arch linux installation
# Version 0.4.2
# created by Benjamin Held and other sources, June 2017

# ${1}: optional flag --local if the installation should be done with local libraries

# setting -e to abort on error
set -e

# define terminal colors
source ../libs/terminal_color.sh

BUILD_PATH="<wrf path>"
WRF_ROOT_PATH="${HOME}/${BUILD_PATH}"
SCRIPT_PATH=$(pwd)

# Check var settings of build path
if [ "${BUILD_PATH}" = "<wrf path>" ]; then
  printf "%bInvalid build path. Please set the <BUILD_PATH> variable. See README.md %b\\n" "${RED}" "${NC}"
  exit 1
fi

# Check for log folder
if ! [ -d 'logs' ]; then
	mkdir logs
fi

# Setting required environment variables
source ./linux/set_env.sh ${WRF_ROOT_PATH}

# Install required basic packages
cd linux || exit 1
sh ./basics.sh

# Preaparing files and folder
cd "${SCRIPT_PATH}/linux" || exit 1
sh ./preparations.sh ${BUILD_PATH} ${1}

# Compiling netcdf bindings
cd "${SCRIPT_PATH}/wrf_preparation" || exit 1
sh ./netcdf.sh ${BUILD_PATH}
# exporting required environment parameters
export LDFLAGS="${LDFLAGS} -L${DIR}/netcdf/lib"
export CPPFLAGS="${CPPFLAGS} -I${DIR}/netcdf/include"
# setting library path while building with shared libraries
export LD_LIBRARY_PATH="${DIR}/hdf5/lib:${DIR}/netcdf/lib:${LD_LIBRARY_PATH}"

# Compiling fortran binding for netcdf
printf "%bStarting fortran bindings in 5 seconds ... %b" "${YELLOW}" "${NC}"
sleep 5
sh ./fortran_bindings.sh ${BUILD_PATH}

# Compiling required libraries
printf "%bStarting library compilation in 5 seconds ... %b" "${YELLOW}" "${NC}"
sleep 5
sh ./install_libraries.sh ${BUILD_PATH}
# exporting required environment parameters
export LDFLAGS="${LDFLAGS} -L${DIR}/grib2/lib"
export CPPFLAGS="${CPPFLAGS} -I${DIR}/grib2/include"

# Running System environment test
printf "%bStarting fortran tests. Press any key ... %b" "${YELLOW}" "${NC}"
read
cd "${SCRIPT_PATH}/wrf_pre_test" || exit 1
sh ./fortran_tests.sh ${BUILD_PATH}

# Running Library compatibility test
printf "%bStarting precompile tests. Press any key ... %b" "${YELLOW}" "${NC}"
read
sh ./wrf_precompile_tests.sh ${BUILD_PATH}

# Compiling the wrf-model
printf "%bStarting WRF compilation. Press any key ... %b" "${YELLOW}" "${NC}"
read
cd "${SCRIPT_PATH}/wrf_compile" || exit 1
sh ./wrf_compile.sh ${BUILD_PATH} ${WRF_ROOT_PATH}

# Compiling the wps modulue
printf "%bStarting WPS compilation in 5 seconds ... %b" "${YELLOW}" "${NC}"
sleep 5
sh ./wps_compile.sh ${BUILD_PATH}

# Adding postprocessing components
printf "%bAdding software packages for result processing ... \\n%b" "${YELLOW}" "${NC}"
sleep 5
cd "${SCRIPT_PATH}/wrf_postprocessing" || exit 1
sh ./wrf_postprocessing.sh
