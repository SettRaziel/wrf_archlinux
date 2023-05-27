#!/bin/bash

# Script that sets the required variables for the model installation
# ${1}: the build path where the wrf model should be installed

# setting required environment variables for the session
export DIR="${1}/libraries"
export CC="gcc"
export CXX="g++"
export FC="gfortran"
export FCFLAGS="-m64"
export F77="mpif77"
export FFLAGS="-m64 -fallow-argument-mismatch"
export PATH="${PATH}:${DIR}/netcdf/bin"
export NETCDF="${DIR}/netcdf"
export PNETCDF="${DIR}/pnetcdf"
export HDF5="${DIR}/hdf5"
export LDFLAGS="-L/usr/include/tirpc"
export CPPFLAGS="-I/usr/include/tirpc"
export PATH="${PATH}:${DIR}/mpich/bin"
export CFLAGS="-fPIC"
export WRFIO_NCD_LARGE_FILE_SUPPORT=1
# no JASPERLIB or JASPERINC here since WPS stores japser, libpng and zlib on its own with --build-grib2-libs
# since the WRF source still thinks we do not support netcdf4 we set this flag to compile the model
export NETCDF_classic=1

# setting library versions for usage (last checked: 2023-05-27)
export WRF_VERSION="4.4"              # latest: 4.4
export WPS_VERSION="4.4"              # latest: 4.4
export HDF_VERSION="1.13"             # latest: 1.13.0
export PNETCDF_VERSION="1.12.3"       # latest: 1.12.3
export NETCDF_VERSION="4.8.1"         # latest: 4.8.1
export NETCDF_FORTRAN_VERSION="4.5.4" # latest: 4.5.4
export MPI_VERSION="4.1.1"            # latest: 4.1.1

export WRF_DIR="${1}/WRF-${WRF_VERSION}"
