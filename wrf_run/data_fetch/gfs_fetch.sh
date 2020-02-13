#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-06 19:18:17
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-02-13 21:22:24

# This script loads the required input data for a 180 h forecast run
# $1 matches the required date yyyymmdd
# $2 matches the required timestamp
# $3 is the storage path
# $4 is the model resolution [0p25, 0p50, 1p00]
# $5 the time period for the model run

# define terminal colors
source ${COLOR_PATH}

# error handling for input parameter
if [ "$#" -ne 5 ]; then
  printf "%bWrong number of arguments. Must be one for <DATE> <TIMESTAMP> <STORAGE_PATH> <GEO_RESOLUTION> <PERIOD>.%b\\n" "${RED}" "${NC}"
  exit 1
fi

sh ./gfs_fetch_curl.sh "${1}" "${2}" "${3}" "${4}" "${5}"
