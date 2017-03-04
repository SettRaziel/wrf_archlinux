#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-03 17:20:53
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-03-04 17:22:45

# Setting required environment variables for the session
export DIR="$1/libraries"
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
export JASPERLIB="$DIR/grib2/lib"
export JASPERINC="$DIR/grib2/include"
