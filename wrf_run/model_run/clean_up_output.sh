#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-12 09:26:31
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-12-15 13:08:51

# Script to run the preprocessing operations

# cleaning up in wps preprocessing folder
SCRIPT_PATH=$(pwd)
now=$(date +"%T")
if [ -z "${LOG_PATH}" ]; then
  printf "Cleaning up output data from last time at %s\\n" "${now}"
else 
	printf "Cleaning up output data from last time at %s\\n" "${now}" >> "${LOG_PATH}/log.info"
fi

# remove previous output files
rm "${HOME}"/wrf_output/wrfout_*
rm "${HOME}"/wrf_output/Han.*
rm "${HOME}"/wrf_output/Ith.*
