#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-02-19 13:25:49
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-11-21 18:56:29

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
  printf "${RED}Invalid build path. Please set the <BUILD_PATH> variable. See README.md ${NC}\n"
  exit 1
fi

# Check for log folder
if ! [ -d 'logs' ]; then
	mkdir logs
fi

# Setting required environment variables
source ./linux/set_env.sh ${WRF_ROOT_PATH}

# Install required basic packages
cd linux
sh ./basics.sh

# Preaparing files and folder
cd ${SCRIPT_PATH}/linux
sh ./preparations.sh ${BUILD_PATH} ${1}

# Compiling netcdf bindings
cd ${SCRIPT_PATH}/wrf_preparation
sh ./netcdf.sh ${BUILD_PATH}
# exporting required environment parameters
export LDFLAGS="${LDFLAGS} -L${DIR}/netcdf/lib"
export CPPFLAGS="${CPPFLAGS} -I${DIR}/netcdf/include"
# setting library path while building with shared libraries
export LD_LIBRARY_PATH="${DIR}/hdf5/lib:${DIR}/netcdf/lib:${LD_LIBRARY_PATH}"

# Compiling fortran binding for netcdf
printf "${YELLOW}Starting fortran bindings in 5 seconds ... ${NC}"
sleep 5
sh ./fortran_bindings.sh ${BUILD_PATH}

# Compiling required libraries
printf "${YELLOW}Starting library compilation in 5 seconds ... ${NC}"
sleep 5
sh ./install_libraries.sh ${BUILD_PATH}
# exporting required environment parameters
export LDFLAGS="${LDFLAGS} -L${DIR}/grib2/lib"
export CPPFLAGS="${CPPFLAGS} -I${DIR}/grib2/include"

# Running System environment test
printf "${YELLOW}Starting fortran tests. Press any key ... ${NC}"
read
cd ${SCRIPT_PATH}/wrf_pre_test
sh ./fortran_tests.sh ${BUILD_PATH}

# Running Library compatibility test
printf "${YELLOW}Starting precompile tests. Press any key ... ${NC}"
read
sh ./wrf_precompile_tests.sh ${BUILD_PATH}

# Compiling the wrf-model
printf "${YELLOW}Starting WRF compilation. Press any key ... ${NC}"
read
cd ${SCRIPT_PATH}/wrf_compile
sh ./wrf_compile.sh ${BUILD_PATH} ${WRF_ROOT_PATH}

# Compiling the wps modulue
printf "${YELLOW}Starting WPS compilation in 5 seconds ... ${NC}"
sleep 5
sh ./wps_compile.sh ${BUILD_PATH}

# Adding postprocessing components
printf "${YELLOW}Adding software packages for result processing ... \n${NC}"
sleep 5
cd ${SCRIPT_PATH}/wrf_postprocessing
sh ./wrf_postprocessing.sh
