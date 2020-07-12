#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-12 09:26:31
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-07-05 11:13:21

# Script to clean up the model results from the last model run in the output folder

# setting -e to abort on error
set -e

if [ -z "${LOG_PATH}" ]; then
  printf "Cleaning up output folder from last run at %s\\n" "$(date +"%T")"
else 
	printf "Cleaning up output folder from last run at %s\\n" "$(date +"%T")" >> "${INFO_LOG}"
fi

# remove previous output files from wrf_output
find "${WRF_DIR}"/test/em_real/  -name 'wrfrst_*' -exec rm {} \;
find "${WRF_OUTPUT}" -name 'wrfout_*' -exec rm {} \;
find "${WRF_OUTPUT}" -name '*.PH' -exec rm {} \;
find "${WRF_OUTPUT}" -name '*.PR' -exec rm {} \;
find "${WRF_OUTPUT}" -name '*.QV' -exec rm {} \;
find "${WRF_OUTPUT}" -name '*.TH' -exec rm {} \;
find "${WRF_OUTPUT}" -name '*.TS' -exec rm {} \;
find "${WRF_OUTPUT}" -name '*.UU' -exec rm {} \;
find "${WRF_OUTPUT}" -name '*.VV' -exec rm {} \;
find "${WRF_OUTPUT}" -name '*.WW' -exec rm {} \;
