#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-12 09:26:31
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-04-26 09:25:03

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
find "${HOME}"/wrf_output -name 'wrfout_*' -exec rm {} \;
find "${HOME}"/wrf_output -name '*.PH' -exec rm {} \;
find "${HOME}"/wrf_output -name '*.PR' -exec rm {} \;
find "${HOME}"/wrf_output -name '*.QV' -exec rm {} \;
find "${HOME}"/wrf_output -name '*.TH' -exec rm {} \;
find "${HOME}"/wrf_output -name '*.TS' -exec rm {} \;
find "${HOME}"/wrf_output -name '*.UU' -exec rm {} \;
find "${HOME}"/wrf_output -name '*.VV' -exec rm {} \;
find "${HOME}"/wrf_output -name '*.WW' -exec rm {} \;
