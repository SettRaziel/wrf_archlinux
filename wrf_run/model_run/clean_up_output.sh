#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-12 09:26:31
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-04-05 17:44:41

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
for FILE_NAME in "${WRF_DIR}"/test/em_real/wrfrst_*; do
  [ -e "${FILE_NAME}" ] && rm "${FILE_NAME}"
done
for FILE_NAME in "${HOME}"/wrf_output/wrfout_*; do
  [ -e "${FILE_NAME}" ] && rm "${FILE_NAME}"
done
for FILE_NAME in "${HOME}"/wrf_output/*.PH; do
  [ -e "${FILE_NAME}" ] && rm "${FILE_NAME}"
done
for FILE_NAME in "${HOME}"/wrf_output/*.QV; do
  [ -e "${FILE_NAME}" ] && rm "${FILE_NAME}"
done
for FILE_NAME in "${HOME}"/wrf_output/*.TH; do
  [ -e "${FILE_NAME}" ] && rm "${FILE_NAME}"
done
for FILE_NAME in "${HOME}"/wrf_output/*.TS; do
  [ -e "${FILE_NAME}" ] && rm "${FILE_NAME}"
done
for FILE_NAME in "${HOME}"/wrf_output/*.UU; do
  [ -e "${FILE_NAME}" ] && rm "${FILE_NAME}"
done
for FILE_NAME in "${HOME}"/wrf_output/*.VV; do
  [ -e "${FILE_NAME}" ] && rm "${FILE_NAME}"
done
