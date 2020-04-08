#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-03 17:20:53
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-04-04 17:00:41

# Script that sets the required variables for the model installation
# ${1}: the build path where the wrf model should be installed

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
export HDF5="${DIR}/hdf5"
export LDFLAGS="-L/usr/include/tirpc"
export CPPFLAGS="-I/usr/include/tirpc"
export PATH="${PATH}:${DIR}/mpich/bin"
export WRFIO_NCD_LARGE_FILE_SUPPORT=1
export JASPERLIB="${DIR}/grib2/lib"
export JASPERINC="${DIR}/grib2/include"

# optional: required when using ncl for output in the library folder
export NCARG_ROOT="${DIR}/ncl"

# Setting library versions for usage (last checked: 2020-04-04)
export WRF_VERSION="4.1.5"            # latest: 4.1.5
export WPS_VERSION="4.1"              # latest: 4.1
export HDF_VERSION="1.12"           # latest: 1.12.0
export NETCDF_VERSION="4.7.4"         # latest: 4.7.4
export NETCDF_FORTRAN_VERSION="4.5.2" # latest: 4.5.2
export MPI_VERSION="3.3"              # latest: 3.3.0
export LIBPNG_VERSION="1.6.37"        # latest: 1.6.37
export ZLIB_VERSION="1.2.11"          # latest: 1.2.11
export JASPER_VERSION="1.900.2"       # latest: 1.900.29 / 2.0.14

export WRF_DIR="${1}/WRF-${WRF_VERSION}"
