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
export HDF5="${DIR}/hdf5"
export LDFLAGS="-L/usr/include/tirpc"
export CPPFLAGS="-I/usr/include/tirpc"
export PATH="${PATH}:${DIR}/mpich/bin"
export CFLAGS="-fPIC"
export WRFIO_NCD_LARGE_FILE_SUPPORT=1

export JASPERLIB="/usr/lib"
export JASPERINC="/usr/include"
# since the WRF source still thinks we do not support netcdf4 we set this flag to compile the model
export NETCDF_classic=1

# setting library versions for usage (last checked: 2026-08-02)
export WRF_VERSION="4.8.0"            # latest: 4.8.0
export WPS_VERSION="4.7.0"            # latest: 4.7.0
export NOAHMP_VERSION="4.8-WRF"       # latest: 5.2.1
export HDF_VERSION="2.2.0"            # latest: 2.2.0
export NETCDF_VERSION="4.10.1"        # latest: 4.10.1
export NETCDF_FORTRAN_VERSION="4.6.4" # latest: 4.6.4
export MPI_VERSION="5.0.1"            # latest: 5.0.1

export WRF_DIR="${1}/WRFV${WRF_VERSION}"
