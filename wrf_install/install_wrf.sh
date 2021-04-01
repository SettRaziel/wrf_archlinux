#!/bin/bash

# main installation script: start the installation of the wrf model on a
# minimal arch linux installation
# Version 0.6.0
# created by Benjamin Held and other sources, June 2017

# setting -e to abort on error
set -e

# define terminal colors
. ../libs/terminal_color.sh

# set from default path
BUILD_PATH="WRF"

while [[ $# -gt 0 ]]; do
  case ${1} in
      -b|--build)
      BUILD_PATH="${2}"; shift; shift;;
      -l|--local)
      LOCAL="--local"; shift;;
      --help)
      sh help/man_help.sh; exit 0;;
      *)
      shift;;
  esac
done

# check var settings of build path
WRF_ROOT_PATH="${HOME}/${BUILD_PATH}"
if [ "${BUILD_PATH}" = "WRF" ]; then
  printf "%bDefault build path ${WRF_ROOT_PATH} will be used.%b\\n" "${RED}" "${NC}"
  printf "%bPlease set a build path as an argument when installing to a different location.%b\\n" "${RED}" "${NC}"
fi

# save script path
SCRIPT_PATH=$(pwd)

# check for log folder
if ! [ -d 'logs' ]; then
	mkdir logs
fi

# setting required environment variables
. ./linux/set_env.sh "${WRF_ROOT_PATH}"

# install required basic packages
cd linux || exit 1
sh ./basics.sh

# preaparing files and folder
cd "${SCRIPT_PATH}/linux" || exit 1
sh ./preparations.sh "${BUILD_PATH}" "${LOCAL}"

# compiling netcdf bindings
cd "${SCRIPT_PATH}/wrf_preparation" || exit 1
sh ./netcdf.sh "${BUILD_PATH}"
# exporting required environment parameters
export LDFLAGS="${LDFLAGS} -L${DIR}/netcdf/lib"
export CPPFLAGS="${CPPFLAGS} -I${DIR}/netcdf/include"
# setting library path while building with shared libraries
export LD_LIBRARY_PATH="${DIR}/hdf5/lib:${DIR}/netcdf/lib:${LD_LIBRARY_PATH}"

# compiling fortran binding for netcdf
printf "%bStarting fortran bindings in 5 seconds ... %b" "${YELLOW}" "${NC}"
sleep 5
sh ./fortran_bindings.sh "${BUILD_PATH}"

# compiling required libraries
printf "%bStarting library compilation in 5 seconds ... %b" "${YELLOW}" "${NC}"
sleep 5
sh ./install_libraries.sh "${BUILD_PATH}"
# exporting required environment parameters
export LDFLAGS="${LDFLAGS} -L${DIR}/grib2/lib"
export CPPFLAGS="${CPPFLAGS} -I${DIR}/grib2/include"

# running system environment test
printf "%bStarting fortran tests. Press any key ... %b" "${YELLOW}" "${NC}"
read
cd "${SCRIPT_PATH}/wrf_pre_test" || exit 1
sh ./fortran_tests.sh "${BUILD_PATH}"

# running library compatibility test
printf "%bStarting precompile tests. Press any key ... %b" "${YELLOW}" "${NC}"
read
sh ./wrf_precompile_tests.sh "${BUILD_PATH}"

# compiling the wrf-model
printf "%bStarting WRF compilation. Press any key ... %b" "${YELLOW}" "${NC}"
read
cd "${SCRIPT_PATH}/wrf_compile" || exit 1
sh ./wrf_compile.sh "${BUILD_PATH}"

# compiling the wps modulue
printf "%bStarting WPS compilation in 5 seconds ... %b" "${YELLOW}" "${NC}"
sleep 5
sh ./wps_compile.sh "${BUILD_PATH}"

# adding postprocessing components
printf "%bAdding software packages for result processing ... \\n%b" "${YELLOW}" "${NC}"
sleep 5
cd "${SCRIPT_PATH}/wrf_postprocessing" || exit 1
sh ./wrf_postprocessing.sh

# generating tar file
cd "${HOME}" || exit 1
tar -cvzf "${BUILD_PATH}.tar.gz" "${BUILD_PATH}"
