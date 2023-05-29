#!/bin/bash

# Script that sets the required variables for the model run
# ${1}: the build path relativ from ${HOME} where the required wrf files
#       are installed

. "${COLOR_PATH}"

# error handling for input parameter
if [ "$#" -ne 1 ]; then
  printf "%bWrong number of arguments. Must be one for <BUILD_PATH>.%b\\n" "${RED}" "${NC}"
  exit 1
fi

# Setting required environment variables for the session
export BUILD_PATH=${HOME}/${1}
export DIR="${BUILD_PATH}/libraries"
export CC="gcc"
export CXX="g++"
export FC="gfortran"
export FCFLAGS="-m64"
export F77="gfortran"
export FFLAGS="-m64"
export PATH="${PATH}:${DIR}/netcdf/bin"
export NETCDF="${DIR}/netcdf"
export PATH="${PATH}:${DIR}/mpich/bin"
export WRFIO_NCD_LARGE_FILE_SUPPORT=1
export JASPERLIB="/usr/lib"
export JASPERINC="/usr/include"
# Adding shared libraries
export LD_LIBRARY_PATH="${DIR}/hdf5/lib:${DIR}/netcdf/lib:${LD_LIBRARY_PATH}"

# Version and directory variables
export WRF_VERSION="4.4"
export WPS_VERSION="4.4"
export WRF_DIR="${BUILD_PATH}/WRF-${WRF_VERSION}"
export WPS_DIR="${BUILD_PATH}/WPS-${WPS_VERSION}"

# output folder for the result images
export WRF_VISUALIZATION="${HOME}/wrf_visualization"
export WRF_OUTPUT="${WRF_VISUALIZATION}/files"
