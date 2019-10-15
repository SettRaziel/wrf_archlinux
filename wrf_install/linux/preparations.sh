#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-02-26 14:21:00
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-10-15 16:21:22

# ${1}: the folder relative to the home path where the files should be installed
# ${2}: the marker if the installation should use local libraries

# define terminal colors
source ../../libs/terminal_color.sh

# setting -e to abort on error
set -e

# loads the majority of the required library, no jasper since version 2 has other buildsystem
function load_libraries() {
# wget specified wrf version
wget http://www2.mmm.ucar.edu/wrf/src/WRFV${WRF_VERSION}.TAR.gz
# wget specified wps version
wget http://www2.mmm.ucar.edu/wrf/src/WPSV${WPS_VERSION}.TAR.gz
# wget specific hdf 5 version
wget https://support.hdfgroup.org/ftp/HDF5/current/src/hdf5-${HDF_VERSION}.tar.gz
# wget specified netcdf version
wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-${NETCDF_VERSION}.tar.gz
# wget specified netcdf fortran bindings
wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-fortran-${NETCDF_FORTRAN_VERSION}.tar.gz
# wget specified mpich version
wget http://www.mpich.org/static/downloads/${MPI_VERSION}/mpich-${MPI_VERSION}.tar.gz
# wget specified libpng version; can only retrieve latest
wget https://download.sourceforge.net/libpng/libpng-${LIBPNG_VERSION}.tar.gz
# wget specified zlib version; can only retrieve latest
wget www.zlib.net/zlib-${ZLIB_VERSION}.tar.gz
# wget specified jasper version
wget http://www.ece.uvic.ca/~frodo/jasper/software/jasper-${JASPER_VERSION}.tar.gz
}

# checks if the given library exists before copying it
function check_library() {
	if [ ! -f ${1} ]; then
		printf "${RED}Missing library ${1}. Aborting... ${NC}\n"
		exit 1
	fi
}

# storing current script path
SCRIPT_PATH=$(pwd)
LIBRARY_PATH="${SCRIPT_PATH}/../../libraries"

# Create destination folder and change to that
if [ -d "${HOME}/${1}" ]; then
  printf "${YELLOW}Directory already exists, removing ... ${NC}\n"
  rm -rf ${HOME}/${1}
fi
mkdir ${HOME}/${1}
cd ${HOME}/${1}


if [ ${2} = '--local' -a -d ${LIBRARY_PATH} ]; then
	check_library ${LIBRARY_PATH}/WRFV${WRF_VERSION}.tar.gz
	check_library ${LIBRARY_PATH}/WPSV${WPS_VERSION}.tar.gz
	check_library ${LIBRARY_PATH}/hdf5-${HDF_VERSION}.tar.gz
	check_library ${LIBRARY_PATH}/netcdf-${NETCDF_VERSION}.tar.gz
	check_library ${LIBRARY_PATH}/netcdf-fortran-${NETCDF_FORTRAN_VERSION}.tar.gz
	check_library ${LIBRARY_PATH}/mpich-${MPI_VERSION}.tar.gz
	check_library ${LIBRARY_PATH}/libpng-${LIBPNG_VERSION}.tar.gz
	check_library ${LIBRARY_PATH}/zlib-${ZLIB_VERSION}.tar.gz
	check_library ${LIBRARY_PATH}/jasper-${JASPER_VERSION}.tar.gz

	cp -r ${LIBRARY_PATH}/* .
else
	load_libraries
	# rename tar gz to lower case endings
	mv WRFV${WRF_VERSION}.TAR.gz WRFV${WRF_VERSION}.tar.gz
	mv WPSV${WPS_VERSION}.TAR.gz WPSV${WPS_VERSION}.tar.gz
fi
