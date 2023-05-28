#!/bin/bash

# ${1}: the folder relative to the home path where the files should be installed
# ${2}: the marker if the installation should use local libraries

# define terminal colors
. ../../libs/terminal_color.sh

# setting -e to abort on error
set -e

# loads the majority of the required library, no jasper since version 2 has other buildsystem
load_libraries() {
# wget specified wrf version
wget -O "WRFV${WRF_VERSION}.tar.gz" "https://github.com/wrf-model/WRF/archive/v${WRF_VERSION}.tar.gz"
# wget specified wps version
wget -O "WPSV${WPS_VERSION}.tar.gz" "https://github.com/wrf-model/WPS/archive/v${WPS_VERSION}.tar.gz"
# wget specific hdf 5 version
wget -O "hdf5-${HDF_VERSION}.tar.gz" "https://github.com/HDFGroup/hdf5/archive/refs/tags/hdf5-${HDF_VERSION}.tar.gz"
# wget specified netcdf version
wget -O "netcdf-${NETCDF_VERSION}.tar.gz" "https://github.com/Unidata/netcdf-c/archive/v${NETCDF_VERSION}.tar.gz"
# wget specified netcdf fortran bindings
wget -O "netcdf-fortran-${NETCDF_FORTRAN_VERSION}.tar.gz" "https://github.com/Unidata/netcdf-fortran/archive/v${NETCDF_FORTRAN_VERSION}.tar.gz"
# wget specified mpich version
wget "http://www.mpich.org/static/downloads/${MPI_VERSION}/mpich-${MPI_VERSION}.tar.gz"
}

# checks if the given library exists before copying it
# ${1}: the folder to the libraries
# ${2}: library archive
check_library() {
	if [ ! -f "${1}/${2}" ]; then
		printf "%bMissing library: %s. Aborting... %b\\n" "${RED}" "${2}" "${NC}"
		exit 1
	fi
}

# storing current script path
SCRIPT_PATH=$(pwd)
LIBRARY_PATH="${SCRIPT_PATH}/../../libraries"

# Create destination folder and change to that
if [ -d "${HOME}/${1}" ]; then
  printf "%bDirectory already exists, removing content... %b\\n" "${YELLOW}" "${NC}"
  rm -rf "${HOME}/${1}"
fi
mkdir "${HOME}/${1}"
cd "${HOME}/${1}"


if [ "${2}" = '--local' -a -d "${LIBRARY_PATH}" ]; then
	# check if required libraries are present
	check_library "${LIBRARY_PATH}" "WRFV${WRF_VERSION}.tar.gz"
	check_library "${LIBRARY_PATH}" "WPSV${WPS_VERSION}.tar.gz"
	check_library "${LIBRARY_PATH}" "hdf5-${HDF_VERSION}.tar.gz"
	check_library "${LIBRARY_PATH}" "pnetcdf-${PNETCDF_VERSION}.tar.gz"
	check_library "${LIBRARY_PATH}" "netcdf-${NETCDF_VERSION}.tar.gz"
	check_library "${LIBRARY_PATH}" "netcdf-fortran-${NETCDF_FORTRAN_VERSION}.tar.gz"
	check_library "${LIBRARY_PATH}" "mpich-${MPI_VERSION}.tar.gz"

	cp -r "${LIBRARY_PATH}"/* .
else
	printf "${YELLOW}Loading libraries: ${NC}\\n"
	load_libraries
fi
