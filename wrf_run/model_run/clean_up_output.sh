#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-12 09:26:31
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-02-14 15:38:01

# Script to run the preprocessing operations

# setting -e to abort on error
set -e

now=$(date +"%T")
if [ -z "${LOG_PATH}" ]; then
  printf "Cleaning up output data from last time at %s\\n" "${now}"
else 
	printf "Cleaning up output data from last time at %s\\n" "${now}" >> "${INFO_LOG}"
fi

# remove previous output files
rm "${BUILD_PATH}"/WRF/test/em_real/wrfrst_*
rm "${HOME}"/wrf_output/wrfout_*
rm "${HOME}"/wrf_output/*.PH
rm "${HOME}"/wrf_output/*.QV
rm "${HOME}"/wrf_output/*.TH
rm "${HOME}"/wrf_output/*.TS
rm "${HOME}"/wrf_output/*.UU
rm "${HOME}"/wrf_output/*.VV
