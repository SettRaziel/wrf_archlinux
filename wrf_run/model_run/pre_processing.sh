#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-07 19:02:57
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-12-15 13:12:07

# Script to start the model run
# $1: the path to the wrf root folder

set -e

# define terminal colors
source ../../libs/terminal_color.sh

# variable declaration
GFS_PATH=${1}
RESOLUTION=${2}

# starting preprocessing steps
now=$(date +"%T")
printf "Starting preprocessing at %s.\\n" "${now}" >> "${LOG_PATH}/log.info"

# opening wps folder
cd "${BUILD_PATH}/WPS" || exit 1

# preprocessing static data: elevation data and geo data
printf "%bpreprocessing static data (geogrid.exe): %b\\n" "${YELLOW}" "${NC}"
./geogrid.exe > "${LOG_PATH}/debug.log"

# processing initial data and boundary data
printf "%bpreprocessing initial and boundary data: %b\\n" "${YELLOW}" "${NC}"
./link_grib.csh "${GFS_PATH}"/gfs.*.pgrb2."${RESOLUTION}".f*
ln -sf ungrib/Variable_Tables/Vtable.GFS ./Vtable
LD_LIBRARY_PATH="${DIR}/grib2/lib" ./ungrib.exe >> "${LOG_PATH}/debug.log"
./metgrid.exe >> "${LOG_PATH}/debug.log"

# starting wrf steps
now=$(date +"%T")
printf "Starting wrf run at %s.\\n" "${now}" >> "${LOG_PATH}/log.info"

# vertical interpolation preprocessing
printf "%bdoing vertical interpolation (real.exe): %b\\n" "${YELLOW}" "${NC}"
cd "${BUILD_PATH}/WRF/test/em_real" || exit 1
ln -sf ../../../WPS/met_em.* .
./real.exe
cp rsl.error.0000 real_error.log

printf "%bstarting wrf run ... %b\\n" "${YELLOW}" "${NC}"
cd "${BUILD_PATH}/WRF/test/em_real" || exit 1
mpirun ./wrf.exe

# logging time stamp
now=$(date +"%T")
printf "Finished wrf run at %s.\\n" "${now}" >> "${LOG_PATH}/log.info"
