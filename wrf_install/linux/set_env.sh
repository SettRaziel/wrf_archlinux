#!/bin/bash

# Script that sets the required variables for the model installation
# ${1}: the build path where the wrf model should be installed

# setting required environment variables for the session
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

# setting library versions for usage (last checked: 2022-04-19)
export WRF_VERSION="4.3"              # latest: 4.3.3
export WPS_VERSION="4.3"              # latest: 4.3.1
export HDF_VERSION="1.13"             # latest: 1.13.0
export NETCDF_VERSION="4.8.1"         # latest: 4.8.1
export NETCDF_FORTRAN_VERSION="4.5.4" # latest: 4.5.4
export MPI_VERSION="3.3"              # latest: 4.0.2
export LIBPNG_VERSION="1.6.37"        # latest: 1.6.37
export ZLIB_VERSION="1.2.12"          # latest: 1.2.12 (CVE-2018-25032)
export JASPER_VERSION="1.900.2"       # latest: 1.900.29 / 3.0.2

export WRF_DIR="${1}/WRF-${WRF_VERSION}"
