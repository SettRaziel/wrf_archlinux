#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-02-26 14:21:00
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-11-20 17:58:48

# loads the majority of the required library, no jasper since version 2 has other buildsystem
function load_libraries() {
# wget specified wrf version
wget http://www2.mmm.ucar.edu/wrf/src/WRFV${WRF_VERSION}.TAR.gz
# wget specified wps version
wget http://www2.mmm.ucar.edu/wrf/src/WPSV${WPS_VERSION}.TAR.gz
# wget specified netcdf version
wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-${NETCDF_VERSION}.tar.gz
# wget specified netcdf fortran bindings
wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-fortran-${NETCDF_FORTRAN_VERSION}.tar.gz
# wget specified mpich version
wget http://www.mpich.org/static/downloads/${MPI_VERSION}/mpich-${MPI_VERSION}.tar.gz
# wget specified libpng version; can only retrieve latest
wget ftp://ftp-osl.osuosl.org/pub/libpng/src/libpng16/libpng-${LIBPNG_VERSION}.tar.gz
# wget specified zlib version; can only retrieve latest
wget www.zlib.net/zlib-${ZLIB_VERSION}.tar.gz
}

# Simple script to copy the library or script files to its designated folders
mkdir ${HOME}/${1}

# Change to lib folder and load possible libraries
cd ${2}

load_libraries

# copy libraries with version specified in version export
cp WRFV${WRF_VERSION}.TAR.gz ${HOME}/${1}/WRFV${WRF_VERSION}.tar.gz
cp WPSV${WPS_VERSION}.TAR.gz ${HOME}/${1}/WPSV${WPS_VERSION}.tar.gz
cp netcdf-${NETCDF_VERSION}.tar.gz ${HOME}/${1}
cp netcdf-fortran-${NETCDF_FORTRAN_VERSION}.tar.gz ${HOME}/${1}
cp mpich-${MPI_VERSION}.tar.gz ${HOME}/${1}
cp libpng-${LIBPNG_VERSION}.tar.gz ${HOME}/${1}
cp zlib-${ZLIB_VERSION}.tar.gz ${HOME}/${1}
cp jasper-${JASPER_VERSION}.tar.gz ${HOME}/${1}

# copy function test archives, requires them to be in that folder
cp ./tests/* ${HOME}/${1}
