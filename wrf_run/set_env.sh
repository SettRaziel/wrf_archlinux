#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-03 17:20:53
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-01-26 11:51:01

# Script that sets the required variables for the model run
# ${1}: the build path relativ from ${HOME} where the required wrf files
#       are installed
# ${2}: the path where the run_model script is stored

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
export LDFLAGS="-L${DIR}/grib2/lib"
export CPPFLAGS="-I${DIR}/grib2/include"
export PATH="${PATH}:${DIR}/mpich/bin"
export WRFIO_NCD_LARGE_FILE_SUPPORT=1
export JASPERLIB="${DIR}/grib2/lib"
export JASPERINC="${DIR}/grib2/include"
# Adding shared libraries
export LD_LIBRARY_PATH="${DIR}/hdf5/lib:${DIR}/netcdf/lib:${LD_LIBRARY_PATH}"

# optional: required when using ncl unpacked in the library folder
export NCARG_ROOT="${DIR}/ncl"
export PATH="${PATH}:${NCARG_ROOT}/bin"

# directory paths for logging files
export LOG_PATH="${2}/logs"
export ERROR_LOG="${LOG_PATH}/error_$(date +"%m_%d").log" # path to error log
export STATUS_LOG="${LOG_PATH}/status.log"
export DEBUG_LOG="${LOG_PATH}/debug.log"
export INFO_LOG="${LOG_PATH}/info.log"
