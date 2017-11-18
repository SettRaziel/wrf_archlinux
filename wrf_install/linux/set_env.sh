#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-03 17:20:53
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-11-18 08:33:25

# Script that sets the required variables for the model installation
# $1: the build path where the wrf should be installed

# Setting required environment variables for the session
export DIR="${1}/libraries"
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

# optional: required when using ncl unpacked in the library folder
export NCARG_ROOT="${DIR}/ncl"

# Setting library versions for download (last checked: 2017-11-16)
export WRF_VERSION="3.8.1"
export WPS_VERSION="3.8.1"
export NETCDF_VERSION="4.4.1.1"
export NETCDF_FORTRAN_VERSION="4.4.4"
export MPI_VERSION="3.2"
export LIBPNG_VERSION="1.6.28"
export ZLIB_VERSION="1.2.11"
export JASPER_VERSION="1.900.1"