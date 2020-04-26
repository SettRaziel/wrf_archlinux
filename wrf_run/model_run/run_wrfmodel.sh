#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-07 19:02:57
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-04-26 10:42:59

# Script to start the model run
# ${1}: the path to the gfs data
# ${2}: the geographic resolution of the input data

# setting -e to abort on error
set -e

# define terminal colors
source "${COLOR_PATH}"

# error handling for input parameter
if [ "$#" -ne 2 ]; then
  printf "%bWrong number of arguments. Must be one for <GFS_PATH> <GEO_RESOLUTION>.%b\\n" "${RED}" "${NC}"
  exit 1
fi

# variable declaration
GFS_PATH=${1}
RESOLUTION=${2}

# starting preprocessing steps
printf "Starting preprocessing at %s.\\n" "$(date +"%T")" >> "${INFO_LOG}"

# opening wps folder
cd "${WPS_DIR}" || exit 1

# preprocessing static data: elevation data and geo data
printf "%bpreprocessing static data (geogrid.exe): %b\\n" "${YELLOW}" "${NC}"
./geogrid.exe > "${DEBUG_LOG}"

# processing initial data and boundary data
printf "%bpreprocessing initial and boundary data: %b\\n" "${YELLOW}" "${NC}"
./link_grib.csh "${GFS_PATH}"/gfs.*.pgrb2."${RESOLUTION}".f*
ln -sf ungrib/Variable_Tables/Vtable.GFS ./Vtable
LD_LIBRARY_PATH="${DIR}/grib2/lib" ./ungrib.exe >> "${DEBUG_LOG}"
./metgrid.exe >> "${DEBUG_LOG}"

# vertical interpolation preprocessing
printf "%bdoing vertical interpolation (real.exe): %b\\n" "${YELLOW}" "${NC}"
printf "Starting real interpolation at %s.\\n" "$(date +"%T")" >> "${INFO_LOG}"
cd "${WRF_DIR}/test/em_real" || exit 1
ln -sf "${WPS_DIR}"/met_em.* .
./real.exe
cp rsl.error.0000 real_error.log

# starting wrf
printf "%bstarting wrf run ... %b\\n" "${YELLOW}" "${NC}"
printf "Starting wrf run at %s.\\n" "$(date +"%T")" >> "${INFO_LOG}"
cd "${WRF_DIR}/test/em_real" || exit 1
mpirun ./wrf.exe

# logging time stamp
printf "Finished wrf run at %s.\\n" "$(date +"%T")" >> "${INFO_LOG}"
