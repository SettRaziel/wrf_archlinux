#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-12 09:26:31
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-02-21 16:40:15

# script to run the necessary preprocessing steps before starting the wrf run
# ${1}: the path to the gfs input data
# ${2}: the resolution of the input data

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

# cleaning up in wps preprocessing folder
SCRIPT_PATH=$(pwd)
now=$(date +"%T")
if [ -z "${LOG_PATH}" ]; then
  printf " Log path is not set, exiting with error."
  exit 1
fi

printf "Cleaning up wps data from last time at %s\\n" "${now}" >> "${INFO_LOG}"
if [ -z "${BUILD_PATH}" ]; then
  printf " Build path is not set, exiting with error."
  exit 1
fi
cd "${BUILD_PATH}/WPS" || exit 1

# remove met_em files from the last run
rm met_em.d01.*

# remove grib files
rm GRIB*

# remove FILE objects of the time stamps
rm FILE*
rm PFILE*

# cleaning up in wrf
now=$(date +"%T")
printf "Cleaning up wrf data from last time at %s\\n" "${now}" >> "${INFO_LOG}"
cd "${BUILD_PATH}/WRF/test/em_real/" || exit 1

# remove met_em files from the last run
rm met_em.d01.*

cd "${SCRIPT_PATH}" || exit 1
sh ./pre_processing.sh "${GFS_PATH}" "${RESOLUTION}"
