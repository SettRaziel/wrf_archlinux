#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-12 09:26:31
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-04-26 09:29:40

# script to run the necessary preprocessing steps before starting the wrf run

# setting -e to abort on error
set -e

# define terminal colors
source "${COLOR_PATH}"

# cleaning up in wps preprocessing folder
if [ -z "${LOG_PATH}" ]; then
  printf " Log path is not set, exiting with error."
  exit 1
fi

printf "Cleaning up wps data from last time at %s\\n" "$(date +"%T")" >> "${INFO_LOG}"
if [ -z "${BUILD_PATH}" ]; then
  printf " Build path is not set, exiting with error."
  exit 1
fi

# remove met_em files from the last run
find "${WPS_DIR}" -name 'met_em.d01.*' -exec rm {} \;

# remove grib files
find "${WPS_DIR}" -name 'GRIB*' -exec rm {} \;

# remove FILE objects of the time stamps
find "${WPS_DIR}" -name 'FILE*' -exec rm {} \;
find "${WPS_DIR}" -name 'PFILE*' -exec rm {} \;

# cleaning up in wrf
printf "Cleaning up wrf data from last time at %s\\n" "$(date +"%T")" >> "${INFO_LOG}"

# remove met_em files from the last run
find "${WRF_DIR}/test/em_real/" -name 'met_em.d01.*' -exec rm {} \;
