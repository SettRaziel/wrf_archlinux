#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-01 18:50:18
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-03-01 18:55:46

# Setting required environment variables for the session
export DIR="/home/raziel/Build_WRF/libraries"
export CC="gcc"
export CXX="g++"
export FC="gfortran"
export FCFLAGS="-m64"
export F77="gfortran"
export FFLAGS="-m64"
export PATH="$PATH:$DIR/netcdf/bin"
export NETCDF="$DIR/netcdf"
export LDFLAGS="-L$DIR/grib2/lib"
export CPPFLAGS="-I$DIR/grib2/include"
export PATH="$PATH:$DIR/mpich/bin"
export WRFIO_NCD_LARGE_FILE_SUPPORT=1
